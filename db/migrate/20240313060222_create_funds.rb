class CreateFunds < ActiveRecord::Migration[7.0]
  def change
    create_table :funds do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :donor_name, null: false
      t.string :phone_number, null: false
      t.decimal :donation_amount, null: false

      t.timestamps
    end
  end
end
