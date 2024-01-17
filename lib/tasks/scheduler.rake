desc "Marks old runs as completed (run on Tuesdays)"
task :mark_all_completed => :environment do
    puts "Marking all runs as completed"
    Run.mark_all_completed
    puts "Done"
end