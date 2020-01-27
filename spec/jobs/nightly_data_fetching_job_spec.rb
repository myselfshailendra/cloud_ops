require "rails_helper"

RSpec.describe NightlyDataFetchingJob do
  before { NightlyDataFetchingJob.schedule! }

  it "matches with enqueued job" do
    expect(Delayed::Job.count).to eq(1)
    expect(Delayed::Job.first.run_at.day).to eq(Date.today.day)
    expect(Delayed::Job.first.queue).to eq('nightly_data_fetch')
  end
end
