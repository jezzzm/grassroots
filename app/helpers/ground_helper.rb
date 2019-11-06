module GroundHelper

  def navigate_to(lat, long, html_class='', text='Navigate')
    link_to(text, "https://www.google.com/maps/dir/?api=1&destination=#{lat},#{long}", :target => '_blank', :class=> html_class)
  end
end
