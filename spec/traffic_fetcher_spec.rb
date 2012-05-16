require '../traffic_fetcher.rb'  # more elegant way to require?

module Traffic
	describe MapQuestFetcher do
		before (:all) do
			@fetcher = MapQuestFetcher.new('Fmjtd%7Cluua2d6t2u%2Cb5%3Do5-hr85g')
		end

		it "returns traffic incident data from MapQuest" do
			@data = @fetcher.fetch("02806")
			@data.should_not be_empty
		end
	end

	describe BingFetcher do
		it "returns traffic incident data from Bing" do
			@fetcher = BingFetcher.new('AmAZzRl0lPmqYJ3i_GW9oaItcaSHgQnphkE1xl6N-1P5gyg68KPWVqvmlJwnxcCN')
			@data = @fetcher.get_incidents
			@data.should_not be_empty
		end
	end
end