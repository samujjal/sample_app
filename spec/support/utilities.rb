
# def full_title(page_title)
#   base_title = "ROR Sample App"
#   if page_title.empty?
#     base_title
#   else
#     "#{base_title} | #{page_title}"
#   end
# end

include ApplicationHelper

def invalid_signup
  fill_in "Name", with: ""
  fill_in "Email", with: "user@example,com"
  fill_in "Password", with: "foobar"
  fill_in "Confirm Password", with: "notfoobar"
  click_button submit
end

def valid_signup
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",      with: "foobar"
  fill_in "Confirm Password",  with: "foobar"
end

def valid_signin(user, options={})
  if options[:no_capybara]
    #Sign in when not using capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end
