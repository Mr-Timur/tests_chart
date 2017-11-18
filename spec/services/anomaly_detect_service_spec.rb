describe AnomalyDetectService do
  before :all do
    Rails.application.load_seed    
  end
  
  subject { AnomalyDetectService.new(sessions) }
    
  let(:sessions) { Session.all.limit(10) }
  let(:abnormal_date) { Date.new(2014, 8, 17) }

  describe "passing test session data" do    
    it "should provide abnormal dates" do
      dates = subject.get_abnormal_dates
      expect(dates).to include(abnormal_date)
    end
    
    it "should provide status counts" do
      status_counts = {error: 1, failed: 2, passed: 4, stopped: 1}
      expect(subject.get_status_counts[abnormal_date]).to eq(status_counts)
    end
  end
  
end