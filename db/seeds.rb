# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

symbols = ["CFP", "DVF", "EOS", "NRO", "PHK", "HSA", "GGN", "VKI", 
           "PMG", "PMF", "PML", "NIO", "AFB", "DHF", "HYP", "AGD", 
           "CSP", "HGT", "HIX", "PHT", "PVX", "VLT", "PPT", "BDJ", 
           "BXU", "ARR", "FSC", "PSE", "ERF", "PGP", "RIT", "HMH", 
           "DUC", "KTF", "VVR", "PFN", "NXP", "MIN", "KST", "DOW"]

puts "Creating New Stocks..."
YahooFinanceIntegrator.new(symbols)

attr = { :email => "user@example.com",
         :password => "password",
         :password_confirmation => "password"
  }
puts "Creating example user"
User.create!(attr)
