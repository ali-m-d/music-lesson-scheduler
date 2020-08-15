class AddDurationToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :duration, :integer
  end
end
