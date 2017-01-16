require 'rubygems'
require 'chinese_pinyin'
require "sinatra"
require "rdiscount"
require "json"

configure :production do

end

set :markdown, :layout_engine => :erb, :layout => :layout

ignoreSet = ['./views/about.md']

get '/' do
	  markdown :deploybiandan3 
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
  
  list = Array.new
  
  #扫描views/*.md文件,构建文件列表
  Dir.glob("#{path}/*.md") { |entry| 
      
      if !ignoreSet.include?(entry) 
      
          File.open("./#{entry}") do |f| 
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
