require "./db/demo.rb"
namespace :demo do
    desc "Add demo records for application run in dev env"
    task :records => :environment do
        Demo.new
    end
end