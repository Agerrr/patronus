class AddImageUrlToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
  		t.string :image_url
  	end
  end
end
