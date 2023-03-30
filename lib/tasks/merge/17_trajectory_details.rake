# frozen_string_literal: true

namespace :merge do
  desc 'Merges trold_trajectory_details to new tables'
  task trajectory_details: :environment do
    Old::TrajectoryDetail.all.each do |old_trajectory_detail|
      TrajectoryDetail.find_or_create_by!(
        grade: old_trajectory_detail.grade,
        account_id: old_trajectory_detail.account_id,
        klass_id: old_trajectory_detail.r_class_id,
        book_id: old_trajectory_detail.book_id,
        student_id: old_trajectory_detail.student_id
      ) do |trajectory_detail|
        trajectory_detail.id = old_trajectory_detail.id
        trajectory_detail.error_count = old_trajectory_detail.error_count
        trajectory_detail.wpm = old_trajectory_detail.wpm
        trajectory_detail.season = old_trajectory_detail.season
        trajectory_detail.entry_date = old_trajectory_detail.entry_date
      end
    end
    puts 'Successfully Merged Trajectory Detail.'
  end
end
