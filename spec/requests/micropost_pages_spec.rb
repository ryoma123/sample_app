require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost count" do
    before { visit root_path }

    it { should have_selector('aside.span4 span', text: user.microposts.count) }
    it { should have_selector('aside.span4 span', text: "micropost".pluralize(user.microposts.count)) }
  end

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "micropost pagination" do
    let(:default_per_page){ 30 }

    context "should not view by 30 microposts" do
      before do
        FactoryGirl.create_list(:micropost, default_per_page, user: user)
        visit user_path(user)
      end

      it { should have_selector('ol.microposts li', count: 30) }
      it { should_not have_selector('div.pagination') }
    end

    context "should view by 31 microposts" do
      before do
        FactoryGirl.create_list(:micropost, default_per_page + 1, user: user)
        visit user_path(user)
      end

      it { should have_selector('ol.microposts li', count: 30) }
      it { should have_selector('div.pagination') }

      it "should have one micropost on the second page" do
        click_link('2')
        should have_selector('ol.microposts li', count: 1)
      end
    end
  end
end
