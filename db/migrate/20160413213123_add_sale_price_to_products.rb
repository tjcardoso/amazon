class AddSalePriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sale_price, :float
  end
end
