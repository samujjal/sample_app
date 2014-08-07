require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before {visit signup_path}

    it {should have_content('Sign up')}
    it {should have_title(full_title('Sign up'))}

  describe "signup" do

    before { visit signup_path}

    let(:submit) { "Create my account"}

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit}.not_to change(User, :count)
      end

      describe "after submission" do
        before {invalid_signup}

        it {should have_title('Sign up')}
        it {should have_content('error')}
        it {should have_content("Name can't be blank")}
        it {should have_content('Email is invalid')}
        it {should have_content("Password confirmation doesn't match Password")}
      end
    end

    describe "with valid information" do
        before {valid_signup}

        it "should create a user" do
          expect {click_button submit}.to change(User, :count).by(1)
        end

        describe "after saving the user" do
          before {click_button submit}
          let(:user) {User.find_by(email: 'user@example.com')}

          it { should have_link('Sign out')}
          it { should have_title(user.name)}
          it { should have_selector('div.alert.alert-success', text: 'Welcome')}
        end

      end
    end
  end



  describe "profile page" do
    let(:user) { FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end
end

