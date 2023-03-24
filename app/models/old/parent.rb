# frozen_string_literal: true

class Old::Parent < Old::ApplicationRecord
  belongs_to :account, class_name: 'Old::Account'
  has_many :students, dependent: :destroy, class_name: 'Old::Student'
  has_many :receipts, through: :students, class_name: 'Old::Receipt'
  # validates_uniqueness_of :father_email, :scope => [:mother_email]
  # validates :father_email, uniqueness: true
  # validates :mother_email, uniqueness: true
  acts_as_paranoid
  scope :active, -> { where(active: true) }
  after_update :confirm_update

  def name
    father = ''
    father = father_first if father_first
    father += ' ' if father_first && father_last
    father += father_last if father_last && (father_last != mother_last)

    mother = ''
    mother = mother_first if mother_first
    mother += ' ' if mother_first && mother_last
    mother += mother_last if mother_last
    s = father
    s += ' & ' if father && mother
    s += mother
    s
  end
end
