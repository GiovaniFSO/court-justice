module Clearance
  module Authorization
    extend ActiveSupport::Concern

    def authorize_admin
      unless (signed_in? && current_user.admin?)
        deny_access
      end
    end

    def authorize_judge
      unless (signed_in? && current_user.judge?)
        deny_access
      end
    end
  end
end
