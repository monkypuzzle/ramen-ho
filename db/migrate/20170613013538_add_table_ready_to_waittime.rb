class AddTableReadyToWaittime < ActiveRecord::Migration[5.0]
  def change
    add_column :waittimes, :table_ready, :boolean, default: false
  end
end
