$listings = $mongo.collection('listings')

module Listings
  extend self

  def create(params)
    data = params.merge!({created_at: Time.now, updated_at: Time.now, num_views: 0})
    if data.addressDetails
      data.lat = data.addressDetails.lat.to_f
      data.lng = data.addressDetails.lng.to_f
    end

    id = $listings.add(data)._id
    
    url_title = URI::encode(data.title.gsub(" ","-"))
    {id: id, url_title: url_title}
  end

  def get(id)
    $listings.get(id)
  end

  ## 

  def gen_search(crit)
   $listings.find(crit).to_a
  end

  def search(term, lat, lng) 
    reg = Regexp.new(term)
    lat, lng = lat.to_f, lng.to_f
    
    $listings.find( { lat: { '$gt' => lat-10, '$lt' => lat+10 },
                      lng: { '$gt' => lng-10, '$lt' => lng+10 },
                      :$or => [{title: reg}, {details: reg}]
                    } ).to_a;

  end


  ## Listings.search_by_content_and_loc('plumber', '')
  ## Listings.search_by_content_and_loc('', 'Haifa')
  def search_by_content_and_loc(content_keyword, location_keyword = nil) 
    crits = [content_crit(content_keyword)]
    crits.push(location_crit(location_keyword)) if location_keyword
    search({:$and => crits })        
  end

  def content_crit(content_keyword)
    reg = Regexp.new(content_keyword)
    content_crit = {:$or => [{title: reg}, {details: reg}]}
  end

  def location_crit(location_keyword)
    reg = Regexp.new location_keyword
    location = {
            :$or => [{:where => reg}, 
                     {'addressDetails.route' => reg},
                     {'addressDetails.locality' => reg}, 
                     {'addressDetails.administrative_area_level_1' => reg},           
                     {'addressDetails.country' => reg},
                    ]
                }
  end
end