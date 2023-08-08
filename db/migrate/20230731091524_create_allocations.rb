class CreateAllocations < ActiveRecord::Migration[7.0]
  def change
    create_table :allocations, id: :uuid do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.references   :allocatee, polymorphic: true, null: false, type: :uuid
      t.references   :substance, polymorphic: true, null: false, type: :uuid

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
