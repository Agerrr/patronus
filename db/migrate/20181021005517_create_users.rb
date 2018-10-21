class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string :user_name
    	t.string :first_name
    	t.string :last_name
    	t.string :university
    	t.string :degree
    	t.string :linkedin_profile
    	t.string :languages
    	t.string :olympiads
    	t.string :courses
    	t.boolean :has_offer 
    	t.string :offer_letter
    	t.string :education
    	t.text :description
    	t.integer :total_funds
      t.timestamps
    end
  end
end
