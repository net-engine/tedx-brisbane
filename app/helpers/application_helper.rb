module ApplicationHelper
  def email_anchor(title, url)
    email_link(title, url, "color: #FF2B06;")
  end

  def email_button(title, url)
    email_link(title, url, "display: inline-block; padding: .25em .75em; margin: -.25em 0; font-weight: bold; text-decoration: none; color: white; background: #FF2B06; border-radius: 4px;")
  end

  private
  
  def email_link(title, url, style)
    link_to title, url, title: title, style: style
  end
end
