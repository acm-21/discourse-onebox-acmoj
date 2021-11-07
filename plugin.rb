# name: discourse-onebox-acmoj
# about: Discourse Onebox for ACMOJ
# version: 0.0.0-dev
# authors: Alan-Liang
# url: https://github.com/acm-21/discourse-onebox-acmoj

require_relative "../../lib/onebox"

Onebox = Onebox

module Onebox
  module Engine
    class AcmojOnebox
      include Engine

      matches_regexp(/^https:\/\/acm\.sjtu\.edu\.cn\/OnlineJudge\//)
      always_https

      def to_html
        return "<strong>Onebox aborted: malicious request detected in #{CGI::escapeHTML(@url)}</strong>" if CGI::unescape(CGI::unescapeHTML(CGI::escapeHTML(@url))).include? 'logout'
        <<-HTML
          <iframe
            src="#{CGI::escapeHTML(@url)}"
            border="0"
            frameborder="no"
            framespacing="0"
            width="100%"></iframe>
        HTML
      end

      def placeholder_html
        to_html
      end
    end
  end
end
