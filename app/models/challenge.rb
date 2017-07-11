class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory
  belongs_to :pharmacy

  def self.import(file, pharmacies, title, product, start_at, end_at, target, laboratory_id)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    j = Challenge.count + 2
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      challenge = new
      pharmacies.each do |pharmacy|
        if pharmacy.cip == row["CIP Pharmacie"]
          challenge.id = j
          challenge.title = title["title"]
          challenge.product = product["product"]
          challenge.start_at = start_at["start_at"]
          challenge.end_at = end_at["end_at"]
          challenge.target = target["target"]
          challenge.statut_type = "no data"
          challenge.user_id = 1
          challenge.laboratory_id = laboratory_id[:id]
          challenge.pharmacy_id = pharmacy.id
          if Email.where(email: row["Email "]).exists? == false
             c = Email.new
             c.email = row["Email "]
             c.pharmacy_id = pharmacy.id
             c.save
          end
          challenge.save!
        end
      end
      # challenge.attributes = row.to_hash.slice(*accepts_nested_attributes_for)
      # challenge.id = j
      j = j + 1
      # challenge.title = "TG"
      # challenge.product = "vooom"
      # challenge.start_at = "2013-02-02"
      # challenge.end_at = "2013-02-02"
      # challenge.target = "cool"
      # challenge.statut_type = "no data"
      # challenge.user_id = 1
      # challenge.laboratory_id = 1
      # challenge.pharmacy_id = 1
      # challenge.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
