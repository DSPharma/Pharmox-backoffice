class ChallengeDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Challenge.count,
      iTotalDisplayRecords: challenges.total_entries,
      aaData: data
    }
  end

private

  def data
    challenges.map do |challenge|
      [
        challenge.statut_type,
        challenge.pharmacy.cip,
        challenge.pharmacy.name,
        challenge.pharmacy.address,
        challenge.pharmacy.postal_code,
        challenge.pharmacy.city,
        1
      ]
    end
  end

  def challenges
    @challenges ||= fetch_challenges
  end

  def fetch_challenges
    challenges = Challenge.order("#{sort_column} #{sort_direction}")
    challenges = challenges.page(page).per_page(per_page)
    if params[:sSearch].present?
      challenges = challenges.where("title like :search or target like :search", search: "%#{params[:sSearch]}%")
    end
    challenges
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
