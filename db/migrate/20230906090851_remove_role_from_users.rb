class RemoveRoleFromUsers < ActiveRecord::Migration[7.0]
  def up
    # drop_table :users
    User.all.each do |x|
      x.add_role(x.role.to_sym, x.account)
    end
    remove_column :users, :role 
  end

  def down
    add_column :users, :role  
    User.all.each do |x|
      x.update(role: x.roles&.first.name)
    end
  end
end
