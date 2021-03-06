

module Search
  extend self

  def google_url(address)
    url="https://maps.googleapis.com/maps/api/geocode/json?address=%s" % URI::encode(address)
  end

  def google_coordinates_by_address(params)
    return params.lat, params.lng if params.lat && params.lng

    google_data = JSON.parse HTTPClient.new.get(google_url(params.location)).body
    location = google_data.results[0].geometry.location
    return location.lat, location.lng
  end
  alias_method :coordinates, :google_coordinates_by_address

end

