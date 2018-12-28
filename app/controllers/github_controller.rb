class GithubController < ApplicationController
  def search
    if params[:user]
      @language = favourite_language(params[:user])
    end
  end

  private

  def favourite_language(user)
    repositories(user).inject(Hash.new(0)) do |languages, repo|
      languages[repo.language] += 1
    end
    languages.max_by{|k,v| v}
  end

  def repositories(user)
    Octokit.repositories(user)
  end
end