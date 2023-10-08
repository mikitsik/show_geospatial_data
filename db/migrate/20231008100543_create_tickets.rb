class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.jsonb :data

      t.timestamps
    end
  end
end
