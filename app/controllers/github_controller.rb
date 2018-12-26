class GithubController < ApplicationController
  def search

  end

  private

  def favourite_language
    repositories(user).inject(Hash.new(0)) do |languages, repo|
      languages[repo.language] += 1
    end
    languages
  end

  def repositories(user)
    Octokit.repositories(user)
  end
end