# Base application helpers
module ApplicationHelper

  # calculate hamonic mean for list of values
  def get_harmonic_mean(score_list)
    return 0 if score_list.size == 0
    sum = 0
    score_list.each  do | score |
      sum += (1.0/score)
    end
    mean = score_list.size / sum
  end

  # Convert 00:00:00 to float min
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
  
  # convert float time to string
  def float_time_to_hhmmss(float_time)
    return if float_time.class == String
    if (float_time && float_time > 0)
      min = float_time.floor
      mm = (min % 60).floor
      hh = (min / 60).floor
      ss = ((float_time - min) * 60).round

      if float_time < 10.0
        return "#{format('%01d', mm)}:#{format('%02d', ss)}"
      elsif float_time < 60.0
        return "#{format('%02d', mm)}:#{format('%02d', ss)}"
      else
        return "#{hh.to_s}:#{format('%02d', mm)}:#{format('%02d', ss)}"
      end
    else
      return ""
    end
  end

  def get_season
    end_year = (Time.now + 6.months).year - 2000
    start_year = end_year - 1
    "#{start_year}/#{end_year}"
  end
  
end
