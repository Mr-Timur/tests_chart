class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string  :started_by
      t.string  :summary_status
      t.float   :duration,            nill: false, default: 0.0
      t.float   :worker_time,         nill: false, default: 0.0
      t.integer :bundle_time,         nill: false, default: 0
      t.integer :num_workers,         nill: false, default: 0
      t.string  :branch,              nill: false
      t.string  :commit_id,           nill: false
      t.integer :started_tests_count, nill: false, default: 0
      t.integer :passed_tests_count,  nill: false, default: 0
      t.integer :failed_tests_count,  nill: false, default: 0
      t.integer :pending_tests_count, nill: false, default: 0
      t.integer :skipped_tests_count,    nill: false, default: 0
      t.integer :error_tests_count,   nill: false, default: 0
      
      t.timestamps
    end
  end
end
