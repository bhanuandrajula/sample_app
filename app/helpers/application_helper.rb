module ApplicationHelper

#Return a title on a page basis
	def title
	base_title = "Bhanu Andrajula App"
		if @title.nil?
		 base_title
		 else
		 "#{base_title} | #{@title}"
		end
	end
	
	def logo
		image_tag("logo.png", :alt => "Sample App", :size => "310x150", :class => "round")
	end
end
