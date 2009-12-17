desc "Execute Kohonen processing"
task :train_kohonen => :environment do
  Train.find( ENV["TRAIN_ID"] ).start
end

