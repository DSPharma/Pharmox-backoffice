require 'roo'

class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory
  belongs_to :pharmacy
  has_many :image
  has_many :input

  def self.import(file, pharmacies, title, product, start_at, end_at, target, laboratory_id)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    # d = DateTime.now
    if Campaign.count == 0
      j = 1
      e = 1
      id_campaign = start_at["start_at"][0 .. 3].to_s + start_at["start_at"][5 .. 6].to_s + format('%04d', e % 1000)
    else
      j = Campaign.count + 1
      c = Campaign.last.campaign_number
      e = c[6 .. 9].to_i
      e = e + 1
      id_campaign = start_at["start_at"][0 .. 3].to_s + start_at["start_at"][5 .. 6].to_s + format('%04d', e % 1000)
    end
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      campaign = new
      pharmacies.each do |pharmacy|
        if pharmacy.cip == row["CIP Pharmacie"]
          campaign.id = j
          campaign.title = title["title"]
          campaign.product = product["product"]
          campaign.start_at = start_at["start_at"]
          campaign.end_at = end_at["end_at"]
          campaign.target = target["target"]
          campaign.statut_type = "no data"
          campaign.campaign_number = id_campaign
          campaign.user_id = 1
          campaign.laboratory_id = laboratory_id[:id]
          campaign.pharmacy_id = pharmacy.id
          p row["Email "]
          if Email.where(email: row["Email "]).exists? == false
             c = Email.new
             c.email = row["Email "]
             c.pharmacy_id = pharmacy.id
             c.save
          end
          campaign.save!
        end
      end
      j = j + 1
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
