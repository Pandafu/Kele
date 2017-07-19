#require './lib/kele'
require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    options = {
      body:{
        "email": email,
        "password": password
      }
    }

    @auth = self.class.post("/sessions", options)
  end
end
