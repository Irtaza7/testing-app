require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryBot.create(:user) }
  subject { Article.new(title: "Something Happens", description: "First test is creating", user: user, status: 0)}

  describe 'validations' do
    it 'check the title is short' do
      expect(subject).to be_valid
    end
    it 'check the title is short' do
      subject.title = "Short"
      expect(subject).not_to be_valid
    end
  end
  describe 'associations' do 
    it 'shows the association' do
      expect(subject).to belong_to(:user)
      expect(subject).to have_many(:comments)
      expect(subject).to have_one_attached(:image)
    end
  end
end
