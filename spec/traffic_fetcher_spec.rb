require_relative '../lib/traffic_fetcher.rb'  # more elegant way to require?

module Traffic
  describe MapQuestFetcher do
    before (:all) do
      @fetcher = MapQuestFetcher.new('Fmjtd%7Cluua2d6t2u%2Cb5%3Do5-hr85g')
    end

    describe '#fetch' do
      it "fetches traffic data for zip code" do
        @fetcher.fetch("02806").should_not be_empty
      end
      
      it "fetches traffic data for city, state" do
        @fetcher.fetch("Baltimore, MD").should_not be_empty
      end

    end
  end

  describe BingFetcher do
    before (:all) do
      @fetcher = BingFetcher.new('AmAZzRl0lPmqYJ3i_GW9oaItcaSHgQnphkE1xl6N-1P5gyg68KPWVqvmlJwnxcCN')
    end

    describe '#fetch' do
      it "fetches traffic data for zip code" do        
        @fetcher.fetch("02806").should_not be_empty
      end

      it "fetches traffic data for city, state" do        
        @fetcher.fetch("Baltimore, MD").should_not be_empty
      end
    end
  end
end