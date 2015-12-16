require 'rails_helper'

RSpec.describe "MicropostPages", type: :request do
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before {  visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do 
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { is_expected.to have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem Ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end

      describe "and post 1 micropost" do 
        before { click_button "Post" }

        it { is_expected.to have_content('1 micropost') }
        it { is_expected.not_to have_content('1 microposts') }
      end

      describe "and post 2 micropost" do
        before do 
          click_button "Post"
          fill_in "micropost_content", with: "hoge"
          click_button "Post"
        end

        it { is_expected.to have_content('2 micropost') }
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect{ click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "pagination" do
    before do
      40.times { FactoryGirl.create(:micropost, user: user) }
      visit root_path
    end
    after { Micropost.delete_all }

    it { is_expected.to have_selector('div.pagination') }


    it "should list each micropost" do
      user.microposts.paginate(page: 1).each do |micropost|
        expect(page).to have_selector('li', text: micropost.content)
      end
    end
  end

  describe "other user7s micropost without delete_link" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:micropost, user: other_user)
      visit user_path(other_user)
    end

    it { is_expected.not_to have_link('delete') }
  end
end
