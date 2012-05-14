require './../traffic_fetcher.rb'  # more elegant way to require?

module Traffic
	describe MapQuestFetcher do
		it "returns data" do
			@fetcher = MapQuestFetcher.new
			@fetcher.run
			@fetcher.data.should_not be_nil
		end
	end
end