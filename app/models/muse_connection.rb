class MuseConnection
  include ApplicationHelper

  def query(endpoint, page, params)
    HTTParty.get("https://api-v2.themuse.com#{endpoint}?api_key=#{secret_key}#{params}&page=#{page}")
  end
end
