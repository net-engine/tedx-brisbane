module ApplicationHelper
  def adult_price
    number_to_currency(Event.price_in_dollars)
  end

  def student_price
    number_to_currency(Event.price_in_dollars_for_student)
  end

  def email_anchor(title, url)
    email_link(title, url, "color: #FF2B06;", 'email-anchor')
  end

  def email_button(title, url)
    email_link(title, url, "display: inline-block; padding: .5em 1.25em; font-weight: bold; text-decoration: none; color: white; background: #FF2B06; border-radius: 4px;", 'email-button')
  end

  def email_divider(color = '#eee')
    content_tag(:hr, '', style: "width: 100%; border: 0; border-top: .25em solid #{color}; margin: 1.5em 0;")
  end

  def email_divider_accent
    email_divider("#FF2B06")
  end

  private
  
  def email_link(title, url, style, klass)
    link_to title, url, title: title, style: style, class: klass
  end
end
