require './../traffic_fetcher.rb'  # more elegant way to require?

module Traffic
	describe MapQuestFetcher do
		before (:each) do
			@fetcher = MapQuestFetcher.new
		end


		# it "gets traffic data" do		
		# 	@fetcher.run
		# 	@fetcher.data.should_not be_nil
		# end

		it "returns traffic incident data" do
			@data = @fetcher.get_incidents
			@data[1].should_not be_nil
		end

	end
end