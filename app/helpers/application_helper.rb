module ApplicationHelper
  def chart_dates(sessions)
    chart_dates = []
    chart_durations = []
    dates = sessions.map{|x| x.created_at.to_date}.uniq # get dates when sessions were
    dates.each do |date|
      one_day_sessions = sessions.where(created_at: date.midnight..date.end_of_day) # get sessions till one day
      difference = one_day_sessions.sum{|x| x.passed_tests_count - x.failed_tests_count}
      
      # Dates should be formated in such way to avoid cutting annotating abnormal days by JS library which parse only date
      chart_dates << [((difference > 0) ? date.strftime("%d_%m_%y") : "(!)_#{date.strftime("%d_%m_%y")}"), one_day_sessions.sum(&:duration)] # Sum of durations per each day
      end
    chart_dates
  end
end
