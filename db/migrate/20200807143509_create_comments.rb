class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :reply
      t.belongs_to :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
