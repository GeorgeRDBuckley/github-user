# frozen_string_literal: true

module Github
  URL = 'https://api.github.com'
  
  def self.repos(user)
    endpoint = "/users/#{user}/repos"
    response = Faraday.get (URL + endpoint)
    repos = self.process_response(response)
    if self.process_response(response).empty?
      raise Github::NoRepos
    else
      return repos
    end
  end

  def self.process_response(response)
    case response.status
    when 404
      raise Github::NotFound
    when 400..599 
      raise Github::Error.new(parsed_results["message"])
    else
      parsed_results = JSON.parse response.body
    end
  end

  class NotFound < StandardError
  end

  class NoRepos < StandardError
  end

  class Error < StandardError
    attr_reader :action

    def initialize(message, action)
      # Call the parent's constructor to set the message
      super(message)

      # Store the action in an instance variable
      @action = action
    end
  end
end