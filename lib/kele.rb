#require './lib/kele'
require 'httparty'
require 'json'
require './lib/roadmap'
require './lib/message'
require './lib/mentor'

class Kele
  include HTTParty
  include Roadmap
  include Message
  include Mentor
  #attr_accessor :auth_token



  def initialize(email, password)
    #fix the issue with the instance variable of base_uri.
    @base_uri = 'https://www.bloc.io/api/v1/'
    options = {
      body:{
        "email": email,
        "password": password
      }    }
    @auth_token = self.class.post("#{@base_uri}/sessions", options)["auth_token"]
  end

  def get_me
      response = JSON.parse(self.class.get(@base_uri + "/users/me", headers: { "Authorization" => @auth_token }).body)
    end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment)
    create_message = {
      "assignment_branch": assignment_branch.to_s,
      "assignment_commit_link": assignment_commit_link.to_s,
      "checkpoint_id": checkpoint_id.to_s,
      "comment": comment.to_s
    }
    response = JSON.parse(self.class.post(@base_uri + "/checkpoint_submissions", headers: { "Authorization" => @auth_token }, :body => create_message).body)
  end
end
