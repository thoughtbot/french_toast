class CreateLastNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :last_notifications do |t|
      t.string :data
      t.string :session, index: true

      t.timestamps
    end
  end
end
