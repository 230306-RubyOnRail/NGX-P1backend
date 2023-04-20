class AddColumnToReinbursements < ActiveRecord::Migration[7.0]
  def change
    add_column :reimbursements, :price, :decimal
  end
end
