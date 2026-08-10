 articles = Article.all

articles.each do |article|
  puts article.user.name
end


