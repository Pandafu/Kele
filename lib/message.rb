module Message

  def get_messages(*page)
    if page[0] == nil
      response = self.class.get(@base_uri + "/message_threads", :headers => {"Authorization" => @auth_token})
    else
      response = self.class.get(@base_uri + "/message_threads", :headers => {"Authorization" => @auth_token}, :body => {"page" => page[0]})
    end
    return JSON.parse(response.body)
  end

  def create_message(sender, id, token, subject, strippedText)
    options = {
        "sender": sender.to_s,
        "id": id.to_s,
        "token": token.to_s,
        "subject": subject.to_s,
        "stripped-text": strippedText.to_s
    }
    response = self.class.post(@base_uri + "/messages", headers: { "Authorization" => @auth_token }, :body => options).body
  end
end
