require 'rails_helper'

RSpec.describe User, type: :model do
  it "メールアドレスとパスワードがあれば有効" do
    user = User.new(email: "test@example.com", password: "password")
    expect(user).to be_valid
  end

  it "パスワードがなければ無効" do
    user = User.new(email: "test@example.com")
    expect(user).not_to be_valid
  end

  it "メールアドレスがなければ無効" do
    user = User.new(password: "password")
    expect(user).not_to be_valid
  end
end

