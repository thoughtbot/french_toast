require "rails/generators/base"
require "rails/generators/migration"

module FrenchToast
  module Generators
    class InstallGenerator < Rail::Generators::Base
      include Rails::Generators::Migration
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
