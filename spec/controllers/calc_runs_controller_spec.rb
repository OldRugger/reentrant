require 'rails_helper'

RSpec.describe CalcRunsController, type: :controller do
  before do
    meet = Meet.create(name: 'test meet OE0014 A',
                date: Time.now)
    Result.import(meet.id,fixture_file_upload('test_data/OE0014.csv'))
    meet = Meet.create(name: 'test meet OE0014 B',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OE0014.csv'))
    meet = Meet.create(name: 'test meet OE0014 C',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OE0014.csv'))
    meet = Meet.create(name: 'test meet OE0014 d',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OE0014.csv'))
    meet = Meet.create(name: 'test meet Or A',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OR.csv'))
    meet = Meet.create(name: 'test meet Or B',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OR.csv'))
    meet = Meet.create(name: 'test meet Or C',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OR.csv'))
    meet = Meet.create(name: 'test meet Or E',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OR.csv'))
    meet = Meet.create(name: 'test meet Or F',
      date: Time.now)
    Result.import(meet.id, fixture_file_upload('test_data/OR.csv'))
    calc_run = CalcRun.new(status: 'in-process', date: DateTime.now.to_date )
    calc_run.save
    start = Time.now
    CalculateResults.new.perform(calc_run)
    finish = Time.now
    calc_run.status = 'complete'
    calc_run.calc_time = finish - start
    calc_run.save
    news = News.create(date: Time.now, text: 'test news item')
  end
  
  describe 'GET #index - before publish' do
    it 'index returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'should not return calc run' do
      get :index
      expect(assigns(:calc_runs)).to match []
    end
    it 'should not return news item' do
      get :index
      expect(assigns(:news)).to match []
    end
  end
  
  describe 'GET #index - before publish' do
    before do
      calc_run = CalcRun.last
      calc_run.publish = true
      calc_run.save
      news = News.last
      news.publish = true
      news.save
    end
    it 'should return calc run' do
      get :index
      expect(assigns(:calc_runs)).to match CalcRun.where(publish: true).all.order(id: :desc)
    end
    it 'should return a news item' do
      get :index
      expect(assigns(:news)).to match News.where(publish: true).all.order(id: :desc)
    end
  end
  
  describe 'GET #show calc_run' do
    it "should return calc run" do
      calc_run = CalcRun.last
      get :show, id: calc_run.id
     
      expect(response.status).to eql(200)
      expect(assigns(:clubs).last).to eql("Woodstock HS")
    end
  end
    
  describe 'GET #show_all to return calc details' do
    it "should do something I'm sure" do
      calc_run = CalcRun.last
      get :show_all, id: calc_run.id
      expect(assigns(:calc_details).last.float_time).to eql 85.66666666666667
    end
  end
  
  describe 'PUT create call run' do
    it "should redirect to admin index" do
      put :create
      expect(response.body).to include('redirected')
    end
  end
end
