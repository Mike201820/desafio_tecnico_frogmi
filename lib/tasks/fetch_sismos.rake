namespace :fetch_sismos do
    desc "Obtener y persistir datos de sismos desde USGS"
    task :obtener_y_persistir => :environment do
      require 'net/http'
      require 'json'
  
      url = URI("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")
      response = Net::HTTP.get(url)
      data = JSON.parse(response)
  
      data["features"].each do |feature|
        next if feature["properties"]["title"].nil? || feature["properties"]["url"].nil? || feature["properties"]["place"].nil? || feature["properties"]["magType"].nil? || feature["geometry"]["coordinates"][0].nil? || feature["geometry"]["coordinates"][1].nil?
  
        magnitude = feature["properties"]["mag"]
        place = feature["properties"]["place"]
        time = Time.at(feature["properties"]["time"] / 1000).to_s
        url = feature["properties"]["url"]
        tsunami = feature["properties"]["tsunami"]
        mag_type = feature["properties"]["magType"]
        title = feature["properties"]["title"]
        longitude = feature["geometry"]["coordinates"][0]
        latitude = feature["geometry"]["coordinates"][1]
  
        next unless magnitude.between?(-1.0, 10.0) && latitude.between?(-90.0, 90.0) && longitude.between?(-180.0, 180.0)
  
        sismo = Sismo.find_or_initialize_by(external_id: feature["id"])
        sismo.update(
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
  