module GroundHelper

  def navigate_to(lat, long, html_class='', text='Navigate')
    raw("<a href='https://www.google.com/maps/dir/?api=1&destination=#{lat},#{long}' target='_blank' class='#{html_class}'>#{text} <i class='fas fa-external-link-alt pl-1'></i></a>")
  end
end
