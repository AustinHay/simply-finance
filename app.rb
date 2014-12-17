require 'rubygems'
require 'sinatra'
require 'yahoo_finance'
require 'json'
require 'sass'
require 'csv'

get '/' do

@stocks = []

@stocks = File.open('/' + params['uploaded_stocks'][:filename], "w") do |f|
    f.write(params['uploaded_stocks'][:tempfile].read)
  		end

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
			:last_trade_price,
			:close,
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
			:market_capitalization]

@metric_names = [ 
			"Symbol",
			"Last Trade Price",  
			"Change", 
			"Close", 
			"EX Div Date",
			"Div Yield",   
			"52 Week High", 
			"52 Week Low",
			"50 Day Moving Avg.", 
     		"200 Day Moving Avg.", 
			"After Hours +/-", 
			"EPS", 
			"FQ EPS Projection",  
			"PE", 
			"Market Cap"]

@num = []
@num = @stocks.count

@data = []
p @data = YahooFinance.quotes(@stocks,@metrics)
p @data[0].name

erb :index,  :locals => {   :stocks => @stocks, 
							:metrics => @metrics,
							:metric_names => @metric_names,
							:data => @data,
							}


:uploaded_stocks
end
