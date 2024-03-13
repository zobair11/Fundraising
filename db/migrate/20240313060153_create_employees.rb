class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :image
      t.decimal :percentage_raised, null: false, default: 0, precision: 8, scale: 2
      t.decimal :target_amount, null: false
      t.string :province, null: false

      t.timestamps
    end
  end
end
