# frozen_string_literal: true

namespace :remove do
  desc 'Remove duplicate Parents and merge students in one'

  task parents: :environment do
    mother_dup_emails = Parent.group(:mother_email).having('count(*) > 1').count.keys
    parent_dup_emails = Parent.where(mother_email: mother_dup_emails).group(:father_email).having('count(*) > 1').count.keys

    father_mapping = {}

    Parent.where(father_email: parent_dup_emails).find_each do |p|
      next if father_mapping[p.father_email].present?

      father_mapping[p.father_email] = p.id
    end

    stds = Student.unscoped.includes(:parent).where(parents: { father_email: parent_dup_emails })

    stds.each do |s|
      s.update(parent_id: father_mapping[s.parent.father_email])
    end

    Parent.where(father_email: parent_dup_emails).where.not(id: father_mapping.values).delete_all
    puts 'Successfully Removed Duplicate.'
  end
end
