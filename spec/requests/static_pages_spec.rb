require 'spec_helper'

describe "Static pages" do

  # test for home page
  describe "Home page" do

    # uses this command to test
    # $ bundle exec rspec spec/requests/static_pages_spec.rb

    # could be any string, like a comment
    it "should have the content 'Sample App'" do
      # simulate visiting the page
      visit '/static_pages/home'
      # expressing the page should have the right content
      expect(page).to have_content('Sample App')
    end

    # correct title
    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end
  end

  # test for help page
  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    # correct title
    it "should have the right title" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    # correct title
    it "should have the right title" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact me'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact me')
    end

    # correct title
    it "should have the right title" do
      visit '/static_pages/contact'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
    end
  end

end