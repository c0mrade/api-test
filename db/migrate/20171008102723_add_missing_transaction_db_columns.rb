class AddMissingTransactionDbColumns < ActiveRecord::Migration[5.1]
  def up
    add_column :transactions, :importer_id, :integer
    add_column :transactions, :exporter_id, :integer
    add_column :transactions, :status, :boolean, default: false
  end

  def down
    remove_column :transactions, :importer_id
    remove_column :transactions, :exporter_id
    remove_column :transactions, :status
  end
end
