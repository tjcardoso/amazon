class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body
      t.float :stars
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
