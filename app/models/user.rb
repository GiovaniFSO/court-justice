class User < ApplicationRecord
  include Clearance::User

  validates :username, presence: true, uniqueness: true

  enum role: { admin: 0, user: 1, lawyer: 2, judge: 3 }

  def email_optional?
    true
  end

  def self.authenticate(username, password)
    return nil  unless (user = find_by_username(username))
    return user if user.authenticated?(password)
  end
end
