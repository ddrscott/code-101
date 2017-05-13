class Subscriber < ApplicationRecord

  # Parse subscribers from a file
  def self.parse(file:)
    RemoteTable.new(file).rows.map do |row|
      Subscriber.new(row)
    end
  end

  def self.import(file:)
    RemoteTable.new(file).rows.map do |row|
      Subscriber.where(row).first_or_create!
    end
  end
end
