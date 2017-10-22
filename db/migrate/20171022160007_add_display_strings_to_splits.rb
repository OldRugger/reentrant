class AddDisplayStringsToSplits < ActiveRecord::Migration
  def change
    add_column :splits, :time_diff_str, :string
    add_column :splits, :time_str, :string
    add_column :splits, :current_time_str, :string
  end
end
