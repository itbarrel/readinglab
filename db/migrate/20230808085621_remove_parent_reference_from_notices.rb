class RemoveParentReferenceFromNotices < ActiveRecord::Migration[7.0]
  def change
    remove_reference :notices, :parent, foreign_key: true, type: :uuid
  end
end
