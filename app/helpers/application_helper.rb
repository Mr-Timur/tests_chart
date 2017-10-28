module ApplicationHelper
  def abnormal_days(data)
    # Get all failed and passed times to compare and indentify abnormal days
    dates = data.map{|k,v| {status: k.first, date: k.last, count: v} if %w(failed passed).include?(k.first)}
    dates = dates.compact.group_by{|x| x[:date]} # group for comparing by one day
    dates.delete_if do |k,v|
      difference = 0
      v.each{|x| x[:status] == 'failed' ? difference -= x[:count] : difference += x[:count]}
      difference > 0
    end
    dates.keys.map{|x| x.strftime('%Y-%m-%d')}
  end

  def status_chart_data(sessions)
    data = sessions.group('summary_status').group('DATE(created_at)').count # get grouped data for chart
    data = data.to_h.sort_by{|k,v| k.last} # sort by date
    data.to_h
  end

  def duration_chart_data(sessions)
    data = sessions.map{|x| [x.created_at.strftime('%a, %d %b %Y %H:%M:%S'), x.duration]}
  end
end
