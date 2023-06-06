class ArticleMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.article_mailer.article_created.subject
  #
  def article_created
    @greeting = "Hi"
    @user = params[:user]
    @article = params[:article]
    attachments['anime.jpeg'] = File.read('app/assets/images/anime.jpeg')
    mail(from: "admin@xyz.com" , to: @user.email, subject: 'following lines are going to failed')
  end
end
