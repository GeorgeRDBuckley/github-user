require 'rails_helper'

describe "Github:" do
  describe "repositories" do
    it "raises Github::NotFound" do
      expect {
        Github.repos("ouefhqgubewndwheifuneuwfnefg")
      }.to raise_error(Github::NotFound)
    end

    it "raises Github::NoRepos" do
      expect {
        Github.repos("asdsd")
      }.to raise_error(Github::NoRepos)
    end

    it "returns JSON" do
      repos = Github.repos("dhh")
      expect(repos.first["owner"]["login"]).to eq("dhh")
    end
  end
end