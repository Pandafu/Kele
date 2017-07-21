#require './lib/kele'
require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
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

  def get_mentor_availability(mentor_id)
      response = Array(self.class.get("/mentors/#{mentor_id}/student_availability", headers: {"Authorization" => @auth_token}))
  end
end
