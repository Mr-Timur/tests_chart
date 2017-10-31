module ApplicationHelper

  def abnormal_days(sessions)
    service = AnomalyDetectService.new(sessions)
    service.get_abnormal_dates(:error) + service.get_abnormal_dates(:failed)
  end

  def status_chart_data(sessions)
    sessions.group([:summary_status, 'date(created_at)']).order('date(created_at)').count
  end

  def duration_chart_data(sessions)
    data = sessions.map{|x| [x.created_at.strftime('%a, %d %b %Y %H:%M:%S'), x.duration]}
  end
end
