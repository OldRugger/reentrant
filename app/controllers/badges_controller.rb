class BadgesController < ApplicationController

  def create
    puts "create badges"
    @season = APP_CONFIG[:season]
    create_navigation_badges
    redirect_to controller: 'admin', action: 'index'
  end
  
  def create_navigation_badges
    Badge.where(season: @season).all.delete_all
    runners = Runner.all
    runners.each do |r|
      create_courses_badges(r)
      expert = check_expert(r)
      next if expert
      pathfinder = check_pathfinder(r)
      next if pathfinder
      check_navigator(r)
    end
  end
  
  def create_courses_badges(r)
    ['Red','Green','Brown','Orange','Yellow','Sprint'].each do |course|
      count = Result.where(course: course, classifier: 0, runner_id: r.id).count
      if count >= 2
        create_course_badges(course, count, r)
      end
    end
  end
  
  def create_course_badges(course, count, runner)
    [15, 10, 5, 2].each do |c|
      if count >= c
        puts "create badge #{course} #{c} #{runner.name}"
        Badge.new(runner_id: runner.id, season: @season, badge_type: 'course',
                  class_type: course, value: c, sort: c,
                  text: "Runner has completed at least #{c} #{course} courses").save!
      end
    end
  end
  
  def check_expert(runner)
    return true if Badge.where(runner_id: runner.id, season: @season, badge_type: "Performance", class_type: 'Expert').count > 0
    courses = ['Red', 'Green']
    if runner.sex == 'M'
      standard = 10.0
    else
      standard = 11.25
      courses << 'Brown'
    end
    results = Result.where(runner_id: runner.id, course: courses).all
    count = 0
    results.each do |r|
      pace = r.float_time/r.length
      count +=1 if pace < standard
      if count >= 2
        create_expert(runner)
        return true
      end
    end
    false
  end
  
  def create_expert(runner)
    puts "Captain #{runner.name}  #{runner.club_description} "
    Badge.new(runner_id: runner.id, season: @season, badge_type: "Performance",
              class_type: "Expert", sort: 1,
              text: "Expert! The runner had at least two races meeting the 'expert' standard").save
  end
  
  def check_pathfinder(runner)
    return true if Badge.where(runner_id: runner.id, season: @season, badge_type: "Performance", class_type: 'Pathfinder').count > 0
    courses = ['Red', 'Green']
    if runner.sex == 'M'
      standard = 12.0
    else
      standard = 13.5
      courses << 'Brown'
    end
    results = Result.where(runner_id: runner.id, course: courses).all
    count = 0
    results.each do |r|
      pace = r.float_time/r.length
      count +=1 if pace < standard
      if count >= 2
        create_pathfinder(runner)
        return true
      end
    end
    false
  end
  
  def create_pathfinder(runner)
    puts "Master #{runner.name}  #{runner.club_description} "
    Badge.new(runner_id: runner.id, season: @season, badge_type: "performance",
              class_type: "Pathfinder", sort: 1, value: "P",
              text: "Pathfinder! The runner had at least two races meeting the 'Pathfinder' standard").save
  end
  
  def check_navigator(runner)
    return true if Badge.where(runner_id: runner.id, season: @season, badge_type: "Performance", class_type: 'Navigator').count > 0
    courses = ['Red', 'Green']
    if runner.sex == 'M'
      standard = 15.0
    else
      standard = 17
      courses << 'Brown'
    end
    results = Result.where(runner_id: runner.id, course: courses).all
    count = 0
    results.each do |r|
      pace = r.float_time/r.length
      count +=1 if pace < standard
      if count >= 2
        create_navigator(runner)
        return true
      end
    end
    false
  end
  
  def create_navigator(runner)
    puts "Boatswain #{runner.name} #{runner.club_description} "
    Badge.new(runner_id: runner.id, season: @season, badge_type: "Performance",
              class_type: "Navigator", sort: 1, value: "N",
              text: "Navigator! The runner had at least two races meeting the 'Navigator' standard").save
  end

  
end
