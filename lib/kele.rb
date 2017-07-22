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
  #attr_reader :auth_token
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    options = {
      body:{
        "email": email,
        "password": password
      }
    }

    @auth = self.class.post("/sessions", options)
    #puts @auth
    @auth_token = @auth["auth_token"]
  end

  def get_me
      response = JSON.parse(self.class.get("/users/me", headers: { "Authorization" => @auth_token }).body)
    end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment)
    create_message = {
      "assignment_branch": assignment_branch.to_str,
      "assignment_commit_link": assignment_commit_link.to_str,
      "checkpoint_id": checkpoint_id.to_str,
      "comment": comment.to_str
    }
    response = JSON.parse(self.class.post("/checkpoint_submissions", headers: { "Authorization" => @auth_token }, :body => create_message).body)
  end
end
