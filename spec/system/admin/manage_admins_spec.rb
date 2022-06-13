require 'rails_helper'

describe 'Admin management' do
  it 'view admins' do
    create(:user, role: :admin)
  end
end
