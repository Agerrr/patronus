class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
    	t.string :account_number
    	t.string :message_id
    	t.string :expiration_date
    	t.string :requisition_id
      t.timestamps
    end
  end
end
