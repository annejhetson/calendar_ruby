class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.column :user_name, :string

      t.timestamps
    end
  end
end
