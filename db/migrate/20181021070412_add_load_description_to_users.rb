class AddLoadDescriptionToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
  		t.text :loan_description
  	end
  end
end
