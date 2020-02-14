class CreateWays < ActiveRecord::Migration[6.0]
  def change
    create_table :ways do |t|
      t.references :city_from, null: false, foreign_key: {to_table: 'cities'}
      t.references :city_to, null: false, foreign_key: {to_table: 'cities'}
      t.integer :distance

      t.timestamps
    end
  end
end
