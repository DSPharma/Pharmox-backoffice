class Pharmacy < ApplicationRecord
  has_many :campaigns
  has_many :challenges
  has_many :emails
  has_many :users

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      pharmacy = new
      p row["CIP"]
      p row
      # pharmacy.attributes = row.to_hash.slice(*accepts_nested_attributes_for)
      # pharmacy.id = i
      pharmacy.cip = row["CIP"]
      pharmacy.name = row["Nom"]
      pharmacy.address = row["Adresse"]
      pharmacy.postal_code = row["CP"]
      pharmacy.city = row["Ville"]
      pharmacy.phone_number = row["Téléphone"]
      pharmacy.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
