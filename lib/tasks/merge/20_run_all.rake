# frozen_string_literal: true

namespace :merge do
  desc 'Run all tasks'
  task run_all: :environment do
    Rake::Task['merge:account_types'].execute
    Rake::Task['merge:accounts'].execute
    Rake::Task['merge:message_templates'].execute
    Rake::Task['merge:rooms'].execute
    Rake::Task['merge:klass_templates'].execute
    Rake::Task['merge:klasses'].execute
    Rake::Task['merge:vacations'].execute
    Rake::Task['merge:parents'].execute
    Rake::Task['merge:students'].execute
    Rake::Task['merge:forms'].execute
    Rake::Task['merge:interviews'].execute
    Rake::Task['merge:receipt_types'].execute
    Rake::Task['merge:receipts'].execute
    Rake::Task['merge:meetings'].execute
    Rake::Task['merge:books'].execute
    Rake::Task['merge:trajectory_details'].execute
    Rake::Task['merge:student_classes'].execute
    Rake::Task['merge:form_detials'].execute
    puts 'Successfully Merged All Task.'
  end
end
