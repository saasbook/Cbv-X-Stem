class AddFieldsToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :address_line1, :string
    add_column :profiles, :address_line2, :string
    add_column :profiles, :city, :string
    add_column :profiles, :state, :string
    add_column :profiles, :country, :string
    add_column :profiles, :postal_code, :string
    add_column :profiles, :phone, :string
    add_column :profiles, :reached_through, :string
  end
end
