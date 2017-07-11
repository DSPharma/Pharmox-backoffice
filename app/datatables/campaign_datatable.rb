class CampaignDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view, product)
    @view = view
    @product = product
    p @product
    p params[:sEcho].to_i
    p campaigns.total_entries
    p "maman"
  end

  def cut (a)
      arr = []
      a.each do |x|
          if !x.include? nil
              arr.push x
          end
      end
      return arr
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Campaign.count,
      iTotalDisplayRecords: campaigns.total_entries,
      aaData: data
    }
  end

private

  def data
    campaigns.map do |campaign|
      [
        campaign.statut_type,
        campaign.pharmacy.cip,
        campaign.pharmacy.name,
        campaign.pharmacy.address,
        campaign.pharmacy.postal_code,
        campaign.pharmacy.city
      ]
    end
  end

  def campaigns
    @campaigns ||= fetch_campaigns
  end

  def fetch_campaigns
    campaigns = Campaign.order("#{sort_column} #{sort_direction}")
    campaigns = campaigns.page(page).per_page(per_page)
    if params[:sSearch].present?
      campaigns = campaigns.where("title like :search or target like :search", search: "%#{params[:sSearch]}%")
    end
    campaigns
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[statut_type id.cip pharmacy_name address postal_code city]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
