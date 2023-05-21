class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.text :description, default: "N/A"
      t.string :status, default: "In Progress"

      t.timestamps
    end
  end
end
