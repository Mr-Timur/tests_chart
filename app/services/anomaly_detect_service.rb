class AnomalyDetectService
  def initialize(sessions)
    @sessions = sessions
  end

  def get_abnormal_dates(status)
    # Get all failed times to detect anomalies
    dates = get_outliers(statuses_per_date(status)).keys
    dates.map{|x| x.strftime('%Y-%m-%d')} # format for JS lib
  end

  private

  def get_failed_counts
    data = sessions.group('date(created_at)', :summary_status).order('date(created_at)').count
    counts = {}
    # Get formatted hash for easier analyzing
    data.each do |k,v|
      old_value = counts[k.first]
      new_value = {"#{k.last}": v}
      counts[k.first] = old_value.present? ? old_value.merge(new_value) : new_value # add new status if date already has another one
    end
    counts
  end

  # Method for grouping statuses count by date
  def statuses_per_date(status)
    data = {}
    get_failed_counts.each{|k,v| data[k] = v[status].to_i}
    data
  end

  # Method which return keys with outlier values from hash values. 
  def get_outliers(data)
    values = data.values
    mean = (values.sum.to_f / values.length)
    standard_deviation = Math.sqrt((1 / values.length.to_f * values.inject(0){|sum, x| sum + (x - mean)**2 }))
    data.keep_if{|k, v| (mean - v).abs > (2 * standard_deviation)} 
  end
  
  attr_reader :sessions
end