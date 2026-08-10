articles = Article.includes(:user)

articles.each do |article|
  puts article.user.name
end

    # articles = Article.eager_load(:user)

     #articles.each do |article|
      #puts article.user.name
    #end 