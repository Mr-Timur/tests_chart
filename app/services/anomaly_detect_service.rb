class AnomalyDetectService
  def initialize(sessions)
    @sessions = sessions
  end

  def get_abnormal_dates
    # Get all failed times to detect anomalies
    statuses = [:error, :failed]
    dates = get_outliers(get_statuses_per_date(statuses)).keys
    dates
  end

  private

  def get_status_counts
    data = sessions.group('date(created_at)', :summary_status).order('date(created_at)').count
    # Get formatted hash for easier analyzing
    counts = data.each_with_object({}) do |(date_status, count), counts|
      old_value = counts[date_status.first]
      new_value = {"#{date_status.last}": count}
      counts[date_status.first] = old_value.present? ? old_value.merge(new_value) : new_value # add new status if date already has another one
    end
    counts
  end

  # Method for grouping statuses count by date
  def get_statuses_per_date(statuses)
    data = get_status_counts.each_with_object({}) do |(date, counts), data|
      data[date] = counts.select{|status| statuses.include?(status)}.values.sum # get sum count of statuses
    end
    data
  end

  # Method which return keys with outlier values from hash values. 
  def get_outliers(dates_statuses_count)
    counts = dates_statuses_count.values
    mean = (counts.sum.to_f / counts.length)
    standard_deviation = Math.sqrt((1 / counts.length.to_f * counts.inject(0){|sum, count| sum + (count - mean)**2 }))
    dates_statuses_count.keep_if{|date, count| (mean - count).abs > (2 * standard_deviation)} 
  end
  
  attr_reader :sessions
end