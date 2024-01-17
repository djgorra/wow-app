require 'rake'
require 'date'

desc "Marks old runs as completed (run on Tuesdays)"
task :mark_all_completed => :environment do
    if Date.today.wday == 2 #i.e. if today is Tuesday, mark runs as completed. If not, do nothing.
        puts "Marking all runs as completed"
        Run.mark_all_completed
        puts "Done"
    else
        puts "Not Tuesday, skipping."
    end
        
end