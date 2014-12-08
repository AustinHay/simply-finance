require 'rubygems'
require 'sinatra'
require 'yahoo_finance'
require 'json'
require 'sass'
require 'csv'

get '/' do

@stocks = []
i = 0
csv_raw_data = File.read('public/data/stocks.csv')
	csv_new_data = CSV.parse(csv_raw_data, :headers => true)
	csv_new_data.each do |row|
	@stocks[i] = row
	i += 1
end


@metrics = [:name,
			:symbol,
			:change,
			:ask,
			:bid,
			:moving_average_50_day,
     		:moving_average_200_day,
			:after_hours_change_real_time,
			:earnings_per_share,
			:eps_estimate_next_quarter,
			:dividend_yield,
			:ex_dividend_date,
			:pe_ratio, 
			:high_52_weeks,
			:low_52_weeks,
			:annualized_gain,
			:market_capitalization]

@metric_names = [ 
			"Symbol", 
			"Change", 
			"Ask", 
			"Bid", 
			"50 Day Moving Avg.", 
     		"200 Day Moving Avg.", 
			"After Hours +/-", 
			"EPS", 
			"FQ EPS Projection", 
			"Div Yield", 
			"EX Div Date", 
			"PE",  
			"52 Week High", 
			"52 Week Low", 
			"Annualized Gain", 
			"Market Cap"]

@num = []
@num = @stocks.count

@data = []
p @data = YahooFinance.quotes(@stocks,@metrics)
p @data[0].name

erb :index,  :locals => {:num => @num,
							:stocks => @stocks, 
							:metrics => @metrics,
							:metric_names => @metric_names,
							:data => @data,
							}


# YahooFinance.quotes do |x|
# 	p x.key
# end

# data.each do |x|
# 	p 
end
