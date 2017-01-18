# You'll need to require these if you
# want to develop while running with ruby.
# The config/rackup.ru requires these as well
# for it's own reasons.
#
# $ ruby heroku-sinatra-app.rb
#
require 'rubygems'
require 'sinatra'
require 'chinese_pinyin'
require "rdiscount"
require "json"

configure :production do
# Configure stuff here you'll want to
# only be run at Heroku at boot

# TIP:  You can get you database information
#       from ENV['DATABASE_URI'] (see /env route below)
end

set :markdown, :layout_engine => :erb, :layout => :layout

# Quick test
get '/' do
	markdown :heroku_sinatra_app
end

get '/about' do
	markdown :about
end

get '/doc/:md' do 
	path = File.read(File.dirname(__FILE__) + "/views/#{params[:md]}.md")
	pass if File.exist?(path)
	markdown path
end

get '/doc.json' do
	path = File.dirname(__FILE__) + "/views"
	ignoreSet = ["#{path}/about.md"]

	list = Array.new
  #扫描views/*.md文件,构建文件列表
  Dir.glob("#{path}/*.md") { |entry| 
      
      if !ignoreSet.include?(entry) 
      
          File.open("#{entry}") do |f| 
            lines = f.readlines
        
            title =  lines[0].sub(/##/, '')#第一行h2标签未文章的标题
            fileName = File.basename(entry, '.md')#filename当做url
            pinyin = Pinyin.t(title, '')#将标题生成拼音
        
            list << {:fileName => fileName, :pinyin => pinyin, :title => title, :url => "/doc/#{fileName}" } 
          end
      end
  }

  content_type :json

  list.to_json
end
# Test at <appname>.heroku.com

# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information

# get '/env' do
#   ENV.inspect
# end
