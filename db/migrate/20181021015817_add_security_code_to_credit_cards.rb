class AddSecurityCodeToCreditCards < ActiveRecord::Migration[5.2]
  def change
  	change_table :cards do |t|
  		t.string :security_code
  	end
  end
end
