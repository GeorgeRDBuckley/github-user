require "rails_helper"

RSpec.describe GithubController, type: :controller do
  describe "search" do
    it "should return a language" do
      post :search, params: { user: "dhh" }
       expect(assigns(:language)).to eq("Ruby")
    end

    it "should return no repositories" do
      post :search, params: { user: "asdsd" }
       expect(assigns(:language)).to eq("User has no repositories")
    end

    it "should return no user found" do
      post :search, params: { user: "ouefhqgubewndwheifuneuwfnefg" }
       expect(assigns(:language)).to eq("No user found")
    end
  end
end