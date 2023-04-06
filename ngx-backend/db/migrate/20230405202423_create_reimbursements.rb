class CreateReimbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :reimbursements do |t|
      t.string :status
      t.string :comment
      t.timestamp :approval_date

      t.timestamps
    end
  end
end
