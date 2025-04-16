class CreateOrganizations < ActiveRecord::Migration[7.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :subdomain

      t.timestamps
    end
    add_index :organizations, :subdomain, unique: true
  end
end
