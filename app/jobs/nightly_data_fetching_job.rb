class NightlyDataFetchingJob
  include Delayed::RecurringJob
  run_every 1.day
  run_at '12:00am'
  timezone 'Asia/Kolkata'
  queue 'nightly_data_fetch'

  def perform
    Service.fetch_and_save_records
  end
end