class AddCompletedToRuns < ActiveRecord::Migration[6.0]
  def change
    add_column :runs, :completed, :boolean, default: false
  end
end
