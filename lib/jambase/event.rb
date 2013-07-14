require 'jambase/venue'
require 'jambase/artist'
module Jambase
  class Event < InfoHash

    def self.by_zip(zipcode, api)
      data = api.connection.get('events', zipCode: zipcode)
      data['Events'].map{|event| new(event, api) }
    end

    def self.by_artist_id(artist_id, api)
      data = api.connection.get('events', ArtistId: artist_id)
      data['Events'].map{|event| new(event, api) }
    end

    def self.by_id(event_id, api)
      data = api.connection.get('events', id: event_id)
      new(data, api)
    end

    def venue
      @venue ||= Venue.new(@attrs['Venue'], api)
    end

    def artists
      @artists ||= @attrs['Artists'].map{|a| Artist.new(a,api) }
    end

    def date
      @date ||= Time.parse(@attrs['Date'])
    end

  end
end
