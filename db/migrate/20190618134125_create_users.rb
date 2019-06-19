class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :rate
      t.integer :discord_id
      t.timestamps
    end
  end
end
