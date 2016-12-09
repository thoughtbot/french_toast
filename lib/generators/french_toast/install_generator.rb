require "rails/generators"
require "rails/generators/active_record"

module FrenchToast
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def copy_last_notification_migration
        migration_template(
          "create_last_notifications.rb",
          "db/migrate/create_last_notifications.rb",
        )
      end
    end
  end
end
