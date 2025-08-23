require 'rails_helper'

RSpec.describe "Seriesbooks", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password") }

  before { sign_in user }

  it "indexページが表示される" do
    get seriesbooks_path
    expect(response).to have_http_status(:ok)
  end

  it "新しい本を作成できる" do
    expect {
      post seriesbooks_path, params: { seriesbook: { title: "テスト本", author: "作者" } }
    }.to change(Seriesbook, :count).by(1)
  end
end
