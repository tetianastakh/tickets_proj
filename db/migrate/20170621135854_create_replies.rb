class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :ticket_id
      t.string :from
      t.text :text

      t.timestamps null: false
    end
  end
end
