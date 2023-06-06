# Preview all emails at http://localhost:3000/rails/mailers/article_mailer
class ArticleMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/article_mailer/article_created
  def article_created
    ArticleMailer.with(user: User.first, article: Article.first).article_created
  end

end
