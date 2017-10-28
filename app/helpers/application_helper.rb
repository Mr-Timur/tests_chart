module ApplicationHelper
  def format_status_data(data)
  end

  def status_chart_data(sessions)
    data = sessions.group('summary_status').group('DATE(created_at)').count # get grouped data for chart
    data = data.to_h.map{|k,v| {date: k.last, count: v, status: k.first}} # move to array of hashes for providing attributes to js lib
    data = data.group_by{|x| x[:date]}.sort_by(&:first) # sort by date
    data = data.to_h
    data.values.each{|x| x.each{|x| x.delete(:date)}}
    data
  end

  def duration_chart_data(sessions)
    data = []
    dates = sessions.map{|x| x.created_at.to_date}.uniq # get dates when sessions were
    dates.each do |date|
      one_day_sessions = sessions.where(created_at: date.midnight..date.end_of_day) # get sessions till one day
      difference = one_day_sessions.sum{|x| x.passed_tests_count - x.failed_tests_count}
      
      # Dates should be formated in such way to avoid cutting annotating abnormal days by JS library which parse only date
      data << {date: ((difference > 0) ? date.strftime("%d_%m_%y") : "(!)_#{date.strftime("%d_%m_%y")}"), duration: one_day_sessions.sum(&:duration)} # Sum of durations per each day
      end
    data
  end
end
