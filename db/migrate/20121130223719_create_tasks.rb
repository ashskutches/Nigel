class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string  :content
      t.string  :source
      t.string  :action
      t.integer :user_id
      t.timestamps
    end
  end
end
