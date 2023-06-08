require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'article_index', type: :system do
  let(:user) {FactoryBot.create(:user)}
  let(:users) {FactoryBot.create(:user)}
  let(:user1) {FactoryBot.create(:user)}
  let!(:article) { create(:article, user: users, title: 'Sample Article', description: 'Lorem ipsum dolor sit amet.') }
  let!(:article1) { create(:article, user: user1, title: 'Checking the creation', description: 'Lorem ipsum dolor sit amet.') }
  let!(:article2) { create(:article, user: user1, title: 'something happens', description: 'Lorem ipsum dolor sit amet.') }
  let!(:article3) { create(:article, user: user, title: 'Capybara Tdd', description: 'Lorem ipsum dolor sit amet.') }

  before do
    login_as(user1, scope: :user)
  end

  scenario 'testing the index page' do 
    visit root_path
    expect(page).to have_content 'something happens'

    expect(page).to have_link 'Delete'
    expect(page).to have_link 'View'
    expect(page).to have_link 'Edit'
    expect(page).to have_link 'PDF'

    expect(page).to have_selector('.card')

    within first(".card") do
      expect(page).to have_content "by #{users.email}"
      expect(page).to have_link 'View'
      expect(page).to have_link 'PDF'
      expect(page).to have_content 'Sample Article'
      expect(page).to have_content 'Lorem ipsum dolor sit amet.'
    end
  end

  scenario 'when user creates a new article' do
    visit root_path

    click_link 'New Article'

    expect(page).to have_content 'Create a new article'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Description'
    expect(page).to have_content 'Image'
    expect(page).to have_field 'Status'

    fill_in 'Title', with: 'Other Article'
    fill_in 'Description', with: 'Lorem ipsum dolor sit amet dolor sit amet'

    select 'unpublish', from: 'Status'

    click_button 'Create Article'

    expect(page).to have_content 'Article saved successfully'
  end

  scenario 'when user clicks on view' do
    visit root_path

    all('a', text: 'View')[0].click

    expect(page).to have_content 'Sample Article'
    expect(page).to have_content 'Comment'

    fill_in 'comment[content]', with: 'This is my comment'

    click_button 'Submit'

    expect(page).to have_content 'This is my comment'
    expect(page).to have_content "by #{user1.email}"
  end

  scenario 'when user clicks on edit button' do 
    visit root_path

    all('a', text: 'Edit')[0].click
    
    expect(page).to have_content 'Lorem ipsum dolor sit amet.'
    expect(page).to have_field 'Status'
    expect(page).to have_link 'Cancel and return to articles listing'

    fill_in 'Description', with: 'I am going to change the description'

    select 'publish', from: 'Status'

    click_button 'Update Article'

    expect(page).to have_content 'Article updated successfully'
    expect(page).to have_content 'Checking the creation'
    expect(page).to have_content 'I am going to change the description'
  end

  scenario 'when user clicks on delete button' do
    visit root_path

    expect(page).to have_link 'Delete'
    accept_alert do
      all('a', text: 'Delete')[0].click
    end
    expect(page).not_to have_content 'Checking the creation'
  end

  scenario 'when user clicks on pdf button' do
    visit root_path

    expect(page).to have_link 'PDF'
    all('a', text: 'PDF')[0].click
  end
end