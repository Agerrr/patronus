class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
    	t.belongs_to :user

    	t.string :title
    	t.text :description
    	t.integer :period_in_months
    	t.integer :amount

      t.timestamps
    end
  end
end
