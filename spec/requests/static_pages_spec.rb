require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
 
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  subject { page }

  describe "Home page" do 
    before { visit root_path }
    it { is_expected.to have_content('Sample App') }
    it { is_expected.to have_title(full_title('')) }
    it { is_expected.not_to have_title('| Home') }
  end

  describe "Help page" do 
    before { visit help_path }
    it { is_expected.to have_content('Help') }
    it { is_expected.to have_title("#{base_title} | Help") }
  end

  describe "About page" do
    before { visit about_path }
    it { is_expected.to have_content('About Us') }
    it { is_expected.to have_title("#{base_title} | About Us") }
  end

  describe "Contact" do
    before { visit contact_path }
    it { is_expected.to have_content('Contact') }
    it { is_expected.to have_title("#{base_title} | Contact") }
  end
end
