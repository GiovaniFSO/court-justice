class ApplicationController < ActionController::Base
  include Clearance::Controller
  around_action :switch_locale

  def switch_locale(&)
    I18n.with_locale(locale_from_header, &)
  end

  private

  def locale_from_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    locale == 'pt' ? 'pt-BR' : locale
  end
end
