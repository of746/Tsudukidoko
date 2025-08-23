require 'rails_helper'

RSpec.describe "ログイン機能", type: :system do
  let!(:user) { User.create!(email: "test@example.com", password: "password") }

  it "正しい情報でログインできる" do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    expect(page).to have_content("ログインしました")
  end
end
