require 'bundler/setup'
require 'rake/testtask'

# Define the test tasks
task_names = %w[lookup bulk_lookup country profanity asn email_validation phone_validation iban_validation payment_fraud]
task_names.each do |task_name|
  Rake::TestTask.new(task_name) do |t|
    t.libs << 'test'
    t.pattern = "test/#{task_name}_test.rb"
    t.verbose = true
  end
end

desc 'Run all tests'
task :test do
  task_names.each { |task_name| Rake::Task[task_name].invoke }
end

desc 'Default task'
task default: :test
