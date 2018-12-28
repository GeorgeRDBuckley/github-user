class GithubController < ApplicationController
  def search
    if params[:user]
      @language = favourite_language(params[:user])
    end
  end

  private

  def favourite_language(user)
    language = {}
    repositories(user).each do |repo|
      language[repo.language] = 0 if language[repo.language].nil?
      language[repo.language] += 1
    end
    language.max_by{|k,v| v}.first
  end

  def repositories(user)
    Octokit.repositories(user)
  end
end