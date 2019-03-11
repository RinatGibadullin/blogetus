require "rails_helper"

describe "Sign In" do
  let(:user) { FactoryBot.create :user }
  let(:unconfirmed_user) { create :user, :not_confirmed }

  def sign_in(email, password)
    visit new_user_session_path

    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_button "Sign in"
  end

  it "Guest signs in with valid credentials" do
    sign_in(user.email, user.password)

    expect(page).to have_content("My account")
  end

  it "Visitor signs in with invalid credentials" do
    sign_in(user.email, "wrong password")

    expect(page).to have_content("Sign in")
    expect(page).to have_content("Invalid Email or password")
  end

  it "Unconfirmed user tries to sign in" do
    visit new_user_session_path

    fill_in :user_email, with: unconfirmed_user.email
    fill_in :user_password, with: unconfirmed_user.password

    click_button "Sign in"

    expect(page).to have_content("You must confirm your email before sign in!")
  end
end
