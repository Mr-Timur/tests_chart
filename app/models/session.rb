# == Schema Information
#
# Table name: sessions
#
#  id                  :integer          not null, primary key
#  started_by          :string
#  summary_status      :string
#  duration            :float            default(0.0)
#  worker_time         :float            default(0.0)
#  bundle_time         :integer          default(0)
#  num_workers         :integer          default(0)
#  branch              :string
#  commit_id           :string
#  started_tests_count :integer          default(0)
#  passed_tests_count  :integer          default(0)
#  failed_tests_count  :integer          default(0)
#  pending_tests_count :integer          default(0)
#  skipped_tests_count :integer          default(0)
#  error_tests_count   :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Session < ActiveRecord::Base
end
