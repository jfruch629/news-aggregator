class Article
  attr_accessor :title, :url, :content
  
  def initialize(title, url, content)
    @title = title
    @url = url
    @content = content
  end
end
