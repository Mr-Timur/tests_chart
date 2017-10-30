module ApplicationHelper
  require 'savanna-outliers'

  def abnormal_days(data)
    # Get all failed times to detect anomalies
    dates = {}
    data.each{|k,v| dates[k.last] = v if k.first == 'failed'} # filter by failed builds
    dates = Savanna::Outliers.get_outliers(dates, :all)
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
