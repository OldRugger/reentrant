include ApplicationHelper
class Split < ActiveRecord::Base
  belongs_to :split_runner
  before_save :set_time_stings
  
  def self.load_results(meet_id, row, file_type)
    self.new.load_results(meet_id, row, file_type)
  end
  
  def load_results(meet_id, row, file_type)
    return if row['Classifier'] != '0'
    course = row['Course'].capitalize
    normalized_course = normalize_course(course)
    controls = Result.where(meet_id: meet_id, course: normalized_course).first.controls
    split_course = SplitCourse.find_or_create_by(meet_id: meet_id,
                                                 course: course)
    if split_course.controls == nil
      split_course.controls = controls
      split_course.save
    end
    if file_type == 'OE0014'
      load_oe0014_splits(split_course, row)
    elsif file_type == 'OR'
      load_or_splits(split_course, row)
    end
  end
    
  def normalize_course(course)
    return 'Green' if ['Greenx','Greeny'].include?(course)
    return 'Brown' if ['Browny','Brownx'].include?(course)
    return 'Orange' if ['Orangex','Orangey'].include?(course)
    return 'Yellow' if ['Yellowx','Yellowy'].include?(course)
    course
  end

  
  def load_oe0014_splits(split_course, row)
    split_runner = get_split_runner(split_course, row, 'OE0014')
    last_control = 0.0
    split_course.controls.times do |i|
      control = i+1
      break if row["Punch#{control}"] == nil
      current_time = get_float_time(row["Punch#{control}"])
      time = current_time - last_control
      Split.new(split_runner_id: split_runner.id,
                current_time: current_time,
                control: control,
                time: time).save
      last_control = current_time
    end
    time = split_runner.total_time - last_control
    Split.new(split_runner_id: split_runner.id,
          current_time: split_runner.total_time,
          control: FINAL_SPLIT,
          time: time).save
  end
  
  def get_split_runner(split_course, row, source)
    runner = Runner.get_runner(row, source)
    if source == 'OE0014'
      split_runner = SplitRunner.new(split_course_id: split_course.id,
                                     runner_id: runner.id,
                                     start_punch: row['Start'],
                                     finish_punch: row['Finish'],
                                     place: row['Place'],
                                     total_time: get_float_time(row['Time']))
    elsif source == 'OR'
      split_runner = SplitRunner.new(split_course_id: split_course.id,
                                     runner_id: runner.id,
                                     start_punch: row['Start'],
                                     finish_punch: row['Finish'],
                                     place: row['Pl'],
                                     total_time: get_float_time(row['Time']))
    end
    split_runner.save
    split_runner
  end
  
  def load_or_splits(split_course, row)
    split_runner = get_split_runner(split_course, row, 'OR')
    last_control = 0.0
    punch = row.find_index { |k,_| k== 'Punch1' }
    split_course.controls.times do |i|
      control = i + 1
      if row[punch] == nil && row['Pl'] == "1"
        # verify control count
        if i != split_course.controls
          puts "updating control count for #{split_course.course} to #{i}"
          split_course.controls = i
          split_course.save
        end
      end
      break if row[punch] == nil
      current_time = get_float_time(row[punch])
      time = current_time - last_control
      Split.new(split_runner_id: split_runner.id,
                current_time: current_time,
                control: control,
                time: time).save
      last_control += time
      punch += 2
    end
    time = split_runner.total_time - last_control
    Split.new(split_runner_id: split_runner.id,
          current_time: split_runner.total_time,
          control: FINAL_SPLIT,
          time: time).save
  end
  
  def get_float_time(time)
    if time
      if time.scan(/(?=:)/).count == 2
        hh, mm, ss = time.split(':')
      else
        hh = 0
        mm, ss = time.split(':')
      end
      return (hh.to_i * 60) + mm.to_i + (ss.to_i / 60.0)
    else
      return 0
    end
  end
  
  # set time values for display
  def set_time_stings
    if self.time_diff
      if self.time_diff < 0
        self.time_diff_str = float_time_to_hhmmss(-self.time_diff)
      else
        self.time_diff_str = float_time_to_hhmmss(self.time_diff)
      end
    end
    self.current_time_str = float_time_to_hhmmss(self.current_time) if self.current_time
    self.time_str = float_time_to_hhmmss(self.time) if self.time
  end

end
