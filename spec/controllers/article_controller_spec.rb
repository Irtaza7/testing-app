require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
    let(:user) { FactoryBot.create( :user )}
    let!(:article) { FactoryBot.create( :article, title: 'Create Article', description: 'Checking for the articles', user: user)}

  describe "GET #index" do
    it 'test the index action' do
      get :index
      expect(assigns(:article)).to eq([article])
      expect(response.status).to eq 200
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    context 'when user is logged in' do
      before { sign_in(user) }
      it 'test the new action' do
        get :new
        expect(assigns(:article)).to be_a_new(Article)
        expect(response.status).to eq 200
        expect(response).to render_template :new
      end
    end
    context 'when user is not logged out' do
      it 'redirects to the sign-in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Get #show" do
    it 'check the format and content of pdf' do
      get :show, params: { id: article.id, format: :pdf }
      expect(response).to be_successful
      expect(response.headers["Content-Type"]).to eq("application/pdf")
      expect(response.headers["Content-Disposition"]).to include("inline")
    end
  end

  describe "Post #create" do
    context 'when the user and logged in and the article is valid' do
      let(:article_exist) { { title: "Test Article", content: "Lorem ipsum" } }
      before do
        sign_in(user)
        post :create, params: {article: article_exist}
      end
      it 'creates the article' do
        expect(Article.count).to eq(1)
        expect(assigns(:article).user).to eq(user)
        expect(response.status).to eq 200
      end
    end

    context 'when the user is logged in but article is not valid' do 
        let(:article_exist) { { title: "", content: "" } }
      before do
        sign_in(user)
        post :create, params: {article: article_exist}
      end
    end
  end
end