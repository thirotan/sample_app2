require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { is_expected.to have_content('Sign in') }
    it { is_expected.to have_title('Sign in') }
  end

  describe "signin" do

    before { visit signin_path }
 
    describe "with invalid information" do
      before { click_button "Sign in" }

      it { is_expected.to have_title('Sign in') }
      it { is_expected.to have_error_message('Invalid') } 

      describe "after visitng another page" do
        before { click_link "Home" }
        it { is_expected.not_to have_error_message('Invalid') } 
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user  }

      it { is_expected.to have_title(user.name) }
      it { is_expected.to have_link('Profile',     href: user_path(user)) }
      it { is_expected.to have_link('Settings',    href: edit_user_path(user)) }
      it { is_expected.to have_link('Sign out',    href: signout_path) }
      it { is_expected.not_to have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { is_expected.to have_link('Sign in') }
      end
    end
  end
end
