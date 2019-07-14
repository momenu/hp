class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :match_record, foreign_key: true
      t.references :user, foreign_key: true
      t.string :name
      t.integer :rate
      t.integer :discord_id
      t.integer :game_num, null: false, default: 0
      t.integer :win_num, null: false, default: 0
      t.integer :lose_num, null: false, default: 0
      t.integer :position, null: false , default: 0
      t.string :twitter
      t.belongs_to :game_record, index: true
      t.timestamps
    end
  end
end
