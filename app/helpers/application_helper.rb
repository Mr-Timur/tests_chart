module ApplicationHelper

  def abnormal_days(sessions)
    service = AnomalyDetectService.new(sessions)
    service.get_abnormal_dates
  end

  def status_chart_data(sessions)
    service = AnomalyDetectService.new(sessions)
    data = service.get_status_counts
    # Get all possible statuses
    statuses = Session.select(:summary_status).uniq.map(&:summary_status)
    # Zeroing missing statuses for correct displaying
    data.each do |date, statuses_count|
      statuses.each do |status|
        statuses_count[status.to_sym] = 0 unless statuses_count[status.to_sym].present?
      end
      data[date] = statuses_count
    end
    data.each_with_object({}){|(date, statuses_count), hash| statuses_count.each{|status, count| hash[[status.to_s, date]] = count}}
  end

  def duration_chart_data(sessions)
    sessions.map{|session| [session.created_at.strftime('%a, %d %b %Y %H:%M:%S'), session.duration]}
  end
end
