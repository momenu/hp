class CreateMatchRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :match_records do |t|
      t.integer :win_team, array: true
      t.integer :lose_team, array: true
      t.integer :team1ids, array: true
      t.integer :team2ids, array: true
      t.string :player1
      t.string :player2
      t.string :player3
      t.string :player4
      t.string :player5
      t.string :player6
      t.string :player7
      t.string :player8
      t.timestamps
    end
  end
end
