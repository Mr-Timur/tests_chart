require 'csv'

# Save all sessions from CSV into DB
log_file = File.read('session_history.csv')
csv = CSV.parse(log_file, headers: true)
csv.each do |row|
  params = row.to_hash
  params['id'] = params.delete('session_id')
  Session.create!(params) unless Session.find_by(id: params['id']) # to avoid duplications
end