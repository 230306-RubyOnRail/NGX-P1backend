class CreateReimbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :reimbursements, if_not_exists: true do |t|
      t.string :status
      t.string :comment
      t.timestamp :approval_date

      t.timestamps
    end
  end
end
