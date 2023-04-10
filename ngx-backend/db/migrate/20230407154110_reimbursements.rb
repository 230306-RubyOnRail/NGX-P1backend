class Reimbursements < ActiveRecord::Migration[7.0]
  def change
    add_reference :reimbursements, :user, foreign_key: true
  end
end
