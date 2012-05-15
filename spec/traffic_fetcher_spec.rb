require './../traffic_fetcher.rb'  # more elegant way to require?

module Traffic
	describe MapQuestFetcher do
		before (:each) do
			@fetcher = MapQuestFetcher.new
		end

		it "returns traffic incident data" do
			@data = @fetcher.get_incidents
			@data.should_not be_empty ]
		end

	end
end