class CreateLastNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :last_notifications do |t|
      t.timestamps

      t.string :session, index: true
      t.string :data
    end
  end
end
