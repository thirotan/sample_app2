require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { is_expected.to have_content(user.name) }
    it { is_expected.to have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }
    
    it { is_expected.to have_content('Sign up') }
    it { is_expected.to have_title(full_title('Sign up')) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
 
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
 
        it { is_expected.to have_title("Sign up")}
        it { is_expected.to have_content("error") }
        it { is_expected.to have_content("can't be blank") }
        it { is_expected.to have_content("invalid") }
        it { is_expected.to have_content("too short") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
     
        it { is_expected.to have_link('Sign out') }
        it { is_expected.to have_title(user.name) }
        it { is_expected.to have_success_message('Welcome') }
      end
    end

  end
end
