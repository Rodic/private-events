class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :title
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
