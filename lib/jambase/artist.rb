module Jambase
  class Artist < InfoHash

    def events
      api.events_by_artist_id(self.id)
    end

  end
end

