#!/usr/bin/env ruby

require_relative 'init'

DB_SERVER = Sequel.connect("mysql2://root@localhost")

# Load the migration extension.
Sequel.extension(:migration)

if ARGV.include?('--recreate')
  puts "recreating the database"
  DB_SERVER.execute("DROP database IF EXISTS #{DB_NAME}")
  DB_SERVER.execute("CREATE DATABASE IF NOT EXISTS #{DB_NAME}")
end

puts "running migrations"

Sequel::Migrator.run(DB, 'migrations', use_transactions: true)

