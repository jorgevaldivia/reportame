module ApplicationHelper

	def google_maps_include
		maps_api_key = "AIzaSyB6ZYKIc8F_Fl-8onRQTy-wWlfvjCnGicE"
		raw "<script type='text/javascript' src='https://maps.googleapis.com/maps/api/js?key=#{maps_api_key}&sensor=true'></script>"
	end

	def mobile_device?
	  if session[:mobile_param]
	    session[:mobile_param] == "1"
	  else
	    request.user_agent =~ /Mobile|webOS/
	  end
	end

end
