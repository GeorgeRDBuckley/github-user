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
        language[repo.language] = 0 if language[repo.language].nil?
        language[repo.language] += 1
      end
      @error = false
      language.max_by{|k,v| v}.first
    rescue Octokit::NotFound
      @error = true
      "No user found"
    rescue Octokit::TooManyRequests
      @error = true
      "Sorry, API limit has been reached"
    rescue Octokit::ClientError => e
      @error = true
      "Sorry, unexpected client error: #{e.message}"
    rescue Octokit::ServerError => e
      @error = true
      "Sorry, unexpected server error: #{e.message}"
    end
  end

  def repositories(user)
    Octokit.repositories(user)
  end
end