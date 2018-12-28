class GithubController < ApplicationController
  def search
    if params[:user]
      @language = favourite_language(params[:user])
      raise
    end
  end

  private

  def favourite_language(user)
    begin
      language = {}
      repositories(user).each do |repo|
        language[repo.language] = 0 if language[repo.language].nil?
        language[repo.language] += 1
      end
      language.max_by{|k,v| v}.first
    rescue Octokit::NotFound
      "No user found"
    rescue Octokit::TooManyRequests
      "Sorry, API limit has been reached"
    rescue Octokit::ClientError => e
      "Sorry, unexpected client error: #{e.message}"
    rescue Octokit::ServerError => e
      "Sorry, unexpected server error: #{e.message}"
    end
  end

  def repositories(user)
    Octokit.repositories(user)
  end
end