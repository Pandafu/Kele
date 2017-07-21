
module Roadmap

  def get_roadmap(roadmap_id)
    response = JSON.parse(self.class.get("/roadmaps/#{roadmap_id}", headers: { "Authorization" => @auth_token }).body)
  end

  def get_checkpoint(checkpoint_id)
    response = JSON.parse(self.class.get("/checkpoints/#{checkpoint_id}", headers: { "Authorization" => @auth_token }).body)
  end
end
