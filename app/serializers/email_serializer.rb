class EmailSerializer < ActiveModel::Serializer
  attributes :key, :message
  self.root = false

  def key
    MANDRILL.key
  end

  def message
    {
      text: object.plain_text_content,
      subject: "Message from TEDx",
      from_email: "noreply@tedxbrisbane.com",
      from_name: "TEDx Brisbane",
      to: message_recipients
    }
  end

  private
  def message_recipients
    [
      {
          email: object.to_address,
          name: object.to_name
      }
    ]
  end

end
