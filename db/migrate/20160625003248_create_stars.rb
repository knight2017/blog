class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.string :ratings
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
