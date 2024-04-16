require 'open-uri'

namespace :sismological_data_3 do
  desc "Fetch and persist sismological data from USGS"
  task fetch: :environment do
    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
    response = URI.open(url)
    data = JSON.parse(response.read)

    data['features'].each do |feature|
      id = feature['id']
      properties = feature['properties']
      coordinates = feature['geometry']['coordinates']

      # Validaciones
      next unless properties['title'] && properties['url'] && properties['place'] && properties['magType'] && coordinates[0] && coordinates[1]
      next if SismologicalEvent.exists?(external_id: id)

      magnitude = properties['mag']
      place = properties['place']
      time = Time.at(properties['time'] / 1000) # Convertir milisegundos a segundos
      url = properties['url']
      tsunami = properties['tsunami']
      mag_type = properties['magType']
      title = properties['title']
      longitude = coordinates[0]
      latitude = coordinates[1]

      # Validar rangos
      next unless magnitude.between?(-1.0, 10.0) && latitude.between?(-90.0, 90.0) && longitude.between?(-180.0, 180.0)

      # Crear evento sismológico
      SismologicalEvent.create!(
        external_id: id,
        magnitude: magnitude,
        place: place,
        time: time,
        url: url,
        tsunami: tsunami,
        mag_type: mag_type,
        title: title,
        longitude: longitude,
        latitude: latitude
      )
    end
  end
end
