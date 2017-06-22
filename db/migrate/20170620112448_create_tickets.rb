class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.string :subject
      t.text :body
      t.string :uniq_identifier
      t.string :from_name
      t.string :from_email

      t.timestamps null: false
    end
  end
end
