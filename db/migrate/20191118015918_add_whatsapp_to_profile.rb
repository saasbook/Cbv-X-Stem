class AddWhatsappToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :whatsapp, :string
  end
end
