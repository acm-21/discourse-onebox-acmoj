# name: discourse-onebox-acmoj
# about: Discourse Onebox for ACMOJ
# version: 0.0.0-dev
# authors: Alan-Liang
# url: https://github.com/acm-21/discourse-onebox-acmoj

class Onebox::Engine::AcmojOnebox
  include Onebox::Engine

  matches_regexp(/^https:\/\/acm\.sjtu\.edu\.cn\/OnlineJudge\//)
  always_https

  def to_html
    return '<strong>Onebox aborted: malicious request detected in #{CGI::escapeHTML(uri.path)}</strong>' if CGI::unescape(CGI::unescapeHTML(CGI::escapeHTML(uri.path))).include? 'logout'
    <<-HTML
      <iframe
        src="#{CGI::escapeHTML(uri.path)}"
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
