class JobClient
  attr_reader :search_params

  def initialize(search_params)
    @search_params = search_params
  end

  def results(page)
    response = connection.query('/jobs', page, params=query_params)
    page_count = response['page_count']
    job_results = response['results'].flatten
    { page_count: page_count, job_results: job_results }
  end

  private

  def connection
    @connection ||= MuseConnection.new
  end

  def query_params
    query_params = [company_params, category_params, level_params, location_params].reject(&:empty?)
    query_params.map{ |param_set| "&#{param_set}" }.join('')
  end

  def company_params
    companies = search_params[:companies] || []
    companies = replace_spaces(companies) if companies.select{ |company| company.include?(" ") }.present?
    companies.present? ? 'company=' + companies.join('&company=') : ""
  end

  def category_params
    categories = search_params[:categories] || []
    categories = replace_ampersands(categories) if categories.select{ |category| category.include?("&") }.present?
    categories = replace_spaces(categories) if categories.select{ |category| category.include?(" ") }.present?
    categories.present? ? 'category=' + categories.join("&category=") : ""
  end

  def level_params
    levels = search_params[:levels] || []
    levels = replace_spaces(levels) if levels.select{ |level| level.include?(" ") }.present?
    levels.present? ? 'level=' + levels.join("&level=") : ""
  end

  def location_params
    locations = search_params[:locations] || []
    locations = replace_commas(locations) if locations.select{ |location| location.include?(",") }.present?
    locations = replace_spaces(locations) if locations.select{ |location| location.include?(" ") }.present?
    locations.present? ? 'location=' + locations.join("&location=") : ""
  end

  def replace_spaces(array)
    array.map{ |elem| elem.gsub(' ', '+') }
  end

  def replace_ampersands(array)
    array.map{ |elem| elem.gsub('&', '%26') }
  end

  def replace_commas(array)
    array.map{ |elem| elem.gsub(',', '%2C') }
  end
end
