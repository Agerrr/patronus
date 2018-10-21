class ModifyUsers < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
  		t.string :birthday
  		t.integer :age
  		t.string :email
  		t.string :gender
  		t.string :nat
  	end
  end
end
