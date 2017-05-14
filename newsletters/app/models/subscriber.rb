# Holds a list of emails to list names
class Subscriber < ApplicationRecord
  # Parse subscribers from a file
  def self.parse(file:)
    RemoteTable.new(file).rows.map do |row|
      Subscriber.new(row)
    end
  end

  def self.import(file:)
    RemoteTable.new(file).rows.map do |row|
      subscriber = Subscriber.where(email: row['email']).first_or_initialize
      subscriber.name = row['name']
      subscriber.list = row['list']
      subscriber.save!
      subscriber
    end
  end

  def self.import_google
    import(file: 'https://docs.google.com/spreadsheets/u/0/d/1NPj5aCisKxU3nC5o94K_PDrvMH_U71xjVkWkZBHC-lY/export?format=csv')
  end

  def self.summary
    counts = Subscriber.group('list').count
      .map { |k, v| { list: k, count: v } }
      .sort_by { |row| row[:count] }
      .reverse

    CSV.generate do |csv|
      csv << counts.first.keys
      counts.each do |h|
        csv << h.values
      end
    end
  end
end
