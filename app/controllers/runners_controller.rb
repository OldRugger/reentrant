class RunnersController < ApplicationController
  def show
    @calc_run = CalcRun.find(params[:calc_id])
    @runner   = Runner.find(params[:id])
    @calc_results = CalcResult.joins(:meet, :result)
                      .select('meets.name as meet_name, meets.date as meet_date, ' +
                              'meets.id as meet_id, ' +
                              'results.course as course, results.length as length, ' +
                              'results.climb as climb, results.float_time as time, ' +
                              'results.classifier as cassifier, results.place as place, ' +
                              'calc_results.score as score')
                        .where(calc_run_id: @calc_run.id, runner_id: @runner.id)
                          .order('meets.date')
    @rankings = RunnerGv.select('course, score, races')
                  .where(calc_run_id: @calc_run.id, runner_id: @runner.id)
    @badges = Badge.where(runner_id: @runner.id).order(season: :desc).order(:sort)

  end
  
  def index
    puts "---> runners index"
    binding.pry
    page = params['page'] || 1
    per  = params['per'] || 25
    binding.pry
    calc_run_id = CalcRun.last.id
    runner_ids = RunnerGv.where(calc_run_id: calc_run_id).all.distinct(:runner_id).pluck(:runner_id)
    runners = Runner.select(:id, :firstname, :surname, :club_description).where(id: runner_ids).order(:surname)
    @runners = runners.page(1).per(25)
    respond_to do |format|
      format.html
      format.json { render :json => @runners }
    end
  end
end
