module Message

  def get_messages(*page)
    if page[0] == nil
      response = self.class.get("/message_threads", :headers => {"Authorization" => @auth_token})
    else
      response = self.class.get("/message_threads", :headers => {"Authorization" => @auth_token}, :body => {"page" => page[0]})
    end
    return JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, strippedText)
    options = {
        "sender": sender,
        "recipient_id": recipient_id.to_str,
        "token": token.to_str,
        "subject": subject.to_str,
        "stripped-text": strippedText.to_str
    }
    response = JSON.parse(self.class.post("/messages", headers: { "Authorization" => @auth_token }, :body => options).body)
  end
end
