class GithubController < ApplicationController
  def search
    if params[:user]
      @language = favourite_language(params[:user])
    end
  end

  private

  def favourite_language(user)
    begin
      language = {}
      repositories(user).each do |repo|
        language[repo["language"]] = 0 if language[repo["language"]].nil?
        language[repo["language"]] += 1
      end
      @error = false
      language.max_by{|k,v| v}.first
    rescue Github::NoRepos
      @error = true
      "User has no repositories"
    rescue Github::NotFound
      @error = true
      "No user found"
    rescue Github::Error => e
      @error = true
      "Sorry: #{e.message}"
    end
  end

  def repositories(user)
    Github.repos(user)
  end
end