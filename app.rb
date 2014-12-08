require 'rubygems'
require 'sinatra'
require 'yahoo_finance'
require 'json'
require 'sass'

get '/' do

@stocks = ["AAPL",
			"GOOG",
			"MSFT",
			"AMZN",
			"NFLX",
			"TSLA",
			"SCTY",
			"VZ",
			"OPWR",
			"PANW",
			"WAG",
			"CYBR",
			"WFM"]

@metrics = [:symbol,
			:ask,
			:bid,
			:change,
			:earnings_per_share,
			:dividend_yield,
			:pe_ratio, 
			:high_52_weeks,
			:low_52_weeks]

p data = YahooFinance.quotes(stocks,metrics)

# YahooFinance.quotes do |x|
# 	p x.key
# end

# data.each do |x|
# 	p 

