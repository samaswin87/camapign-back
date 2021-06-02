require "./db/demo.rb"
namespace :demo do
    desc "Add demo records for application run in dev env"
    task :records => :environment do
        puts "\nDroping DB"
        Rake::Task["db:drop"].invoke
        puts "\nCreating DB"
        Rake::Task["db:create"].invoke
        puts "\nMigrating DB"
        Rake::Task["db:migrate"].invoke
        puts "\nPush Demo records to DB"
        Demo.new
        puts "\nProcess completed"
    end
end