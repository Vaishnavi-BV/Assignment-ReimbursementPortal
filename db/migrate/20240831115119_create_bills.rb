class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.integer :amount
      t.string :bill_type
      t.string :status, default: 'pending', null: false
      t.datetime :submission_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
