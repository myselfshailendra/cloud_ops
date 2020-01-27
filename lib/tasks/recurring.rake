namespace :recurring do
  desc "Adds a rake task for fetching pricing data from amazon server"
  task nightly_data_fetch: :environment do
    NightlyDataFetchingJob.schedule!
  end
end