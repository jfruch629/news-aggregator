require "sinatra"
require "csv"
require 'pry'

set :bind, '0.0.0.0'

get "/" do
  erb :homepage
end

get "/articles" do
  @articles = []
  File.foreach("saved_articles.csv") do |line|
    @articles << line.split(',')
  end
  erb :articles
end

get "/articles/new" do
  @new_article = params
  erb :article_template
end

post "/create" do
  @article_title = params[:article_title]
  @article_author = params[:article_author]
  @article_content = params[:article_content]
   File.open("./saved_articles.csv", "a+") do |file|
    file.puts(@article_title + "," + @article_author + "," + @article_content + "\n")
  end
  redirect "/articles"
end


get "/articles/:article_name" do
  @article_name = params[:article_name]
  file = File.open("saved_articles.csv", "r")
  while (line = file.gets)
    parsed_line = line.split(',')
    if parsed_line[0] == @article_name
      @current_article = line.split(',')
    end
  end
  erb :show_article
end
