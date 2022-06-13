require 'rails_helper'

describe User do
  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }

    it 'username must to be uniq' do
      create(:user, username: 'jhondoe')
      user = User.new(username: 'jhondoe')

      user.valid?

      expect(user.errors[:username]).to include('has already been taken')
    end

    it 'email must to be uniq' do
      create(:user, email: 'jhon@doe.com')
      user = User.new(email: 'jhon@doe.com')

      user.valid?

      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'authenticate method params nil' do
      user = User.authenticate(nil, nil)

      expect(user).to eq(nil)
    end

    it 'authenticate method valid params' do
      create(:user, username: 'jhondoe', password: '123456')
      user = User.authenticate('jhondoe', '123456')

      expect(user).to_not eq(nil)
    end
  end
end
