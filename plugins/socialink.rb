# Title: Socialink plugin for ocotpress.
# Author: Hemanth.HM [h3manth.com]
module Jekyll
  class SociaLink < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      if /(?<social>\S+\/?\d?)(?:\s+(?<handle>[\w,]+))?/ =~ markup
        @social = social
        @handle = handle
      end
    end

    def render(context)
      if @social and @handle
	links = {
          "fb" => "https://facebook.com/", 
          "tw" => "https://twitter.com/",
          "in" => "http://linkedin.com/in/",
          "gp" => "http://profiles.google.com/",
          "fl" => "http://www.flickr.com/people/",
	  "gh" => "https://github.com/"
        }
	if links.has_key?(@social)
          link = links[@social] + @handle
          "<a href='#{link}'>#{@handle}</a>"
        end
      else
        "Error processing input, expected syntax: {% sl social handle %}"
      end
    end
  end
end

Liquid::Template.register_tag('sl', Jekyll::SociaLink)
