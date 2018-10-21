class AddInvetstorBooleanToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
  		t.boolean :is_investor
  	end
  end
end
