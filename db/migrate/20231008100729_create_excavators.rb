class CreateExcavators < ActiveRecord::Migration[7.1]
  def change
    create_table :excavators do |t|
      t.jsonb :data
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
