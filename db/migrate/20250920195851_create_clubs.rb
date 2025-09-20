class CreateClubs < ActiveRecord::Migration[7.1]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :city
      t.string :country
      t.integer :founded_year
      t.string :stadium_name
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
