module Mentor
  def get_mentor_availability(mentor_id)
      response = Array(self.class.get(@base_uri + "/mentors/#{mentor_id}/student_availability", headers: {"Authorization" => @auth_token}))
  end
end
