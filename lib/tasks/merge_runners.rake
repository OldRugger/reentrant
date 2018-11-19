namespace :runners do
  desc "set display values for split times"
  task :merge, [:source, :target, :merge] => [:environment]  do |task, args|
    source_runner = Runner.find(args[:source].to_i)
    target_runner = Runner.find(args[:target].to_i)
    merge = (args[:merge] == 'true') ? true : false
    puts "Merge runner(#{merge}): #{source_runner.name}(#{source_runner.id}) into #{target_runner.name}(#{target_runner.id})"
    if merge
      merge_runners(source_runner, target_runner)
    end
  end
  
  def merge_runners(source, target)
    puts "Merge Runners "
    puts "---> Results"
    res = Result.where(runner_id: source.id).update_all(runner_id: target.id)
    puts "-------> rows updated #{res}"
    puts "---> Badges"
    res = Badge.where(runner_id: source.id).update_all(runner_id: target.id)
    puts "-------> rows updated #{res}"
    puts "---> RunnerGv"
    res = RunnerGv.where(runner_id: source.id).update_all(runner_id: target.id)
    puts "-------> rows updated #{res}"
    puts "---> SplitRunner"
    res = SplitRunner.where(runner_id: source.id).update_all(runner_id: target.id)
    puts "-------> rows updated #{res}"
    puts "---> CalcResult"
    res = CalcResult.where(runner_id: source.id).update_all(runner_id: target.id)
    puts "-------> rows updated #{res}"
    puts "---> RankingAssignment"
    res = RankingAssignment.where(runner_id: source.id).update_all(runner_id: target.id)
    puts "-------> rows updated #{res}"
    source.destroy
    puts "source deleted"
  end
end

