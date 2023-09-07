class RemoveRoleFromUsers < ActiveRecord::Migration[7.0]
  def up
    # drop_table :users
    role_map = { '0': :admin, '1': :supervisor, '2': :teacher, '3': :super_admin }
    User.all.each do |x|
      x.add_role(role_map[x.role.to_s.to_sym], x.account) unless x.role.nil?
    end
    remove_column :users, :role 
  end

  def down
    add_column :users, :role, :integer
    User.all.each do |x|
      x.update(role: x.roles&.first.name)
    end
  end
end
