class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end