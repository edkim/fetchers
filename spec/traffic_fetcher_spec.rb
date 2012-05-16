require './../traffic_fetcher.rb'  # more elegant way to require?

module Traffic
	describe MapQuestFetcher do
		before (:each) do
			@fetcher = MapQuestFetcher.new
		end

		it "returns traffic incident data from MapQuest" do
			@data = @fetcher.get_incidents
			@data.should_not be_empty ]
		end
	end

	describe BingFetcher do
		it "returns traffic incident data from Bing" do
			@fetcher = BingFetcher.new
			@data = @fetcher.get_incidents
			@data.should_not be_empty
		end
	end
	
end