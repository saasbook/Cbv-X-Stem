class AddCompleteFieldsToPatient < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :birthday, :date
    add_column :profiles, :sex, :string
    add_column :profiles, :health_plan, :string
    add_column :profiles, :contacts, :string
    add_column :profiles, :weight, :string
    add_column :profiles, :height, :string
    add_column :profiles, :smoke, :boolean
    add_column :profiles, :smoke_a_day, :int
    add_column :profiles, :alcohol, :boolean
    add_column :profiles, :alcohol_use, :string
    add_column :profiles, :current_job, :string
    add_column :profiles, :exercise, :string
    add_column :profiles, :doctor, :string
  end
end
