require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    let(:user) do
      User.create!(
        first_name: 'Han',
        last_name: 'Solo',
        email: 'millenium@falcon.net',
        password: 'easychewie',
        password_confirmation: 'easychewie'
      )
    end
    it 'should be valid when created with valid credentials' do
      expect(user).to be_valid
    end
    it "should not be valid when passwords doesn't match" do

      user.password_confirmation = 'easych3wie'
      user.valid?
      expect(user.errors.full_messages).to eq(
        ["Password confirmation doesn't match Password"]
      )
    end
    it "should not be valid when password aren't present" do
      user.password = nil
      user.valid?
      expect(user.errors.full_messages).to include (
        "Password can't be blank"
      )
    end


    it 'should not be valid if the email is already in use' do
      user
      user2 = User.new(
        first_name: 'Lando',
        last_name: 'Calrissian',
        email: 'millenium@falcon.net',
        password: 'punchit',
        password_confirmation: 'punchit'
      )
      user2.valid?
      expect(user2.errors.full_messages).to eq(['Email has already been taken'])
    end


    it 'should not be valid without an email' do
      user.email = nil
      user.valid?
      expect(user.errors.full_messages).to include(
        "Email can't be blank"
        )
    end

    it 'should not be valid without a first name' do
      user.first_name = nil
      user.valid?
      expect(user.errors.full_messages).to eq(["First name can't be blank"])
    end
    it 'should not be valid without a last name' do
      user.last_name = nil
      user.valid?
      expect(user.errors.full_messages).to eq(["Last name can't be blank"])
    end
    it 'should have a password over 2 characters' do
      user.password = 'ik'
      user.password_confirmation = 'ik'
      user.valid?
      expect(user.errors.full_messages).to eq(
        ['Password is too short (minimum is 2 characters)']
      )
    end
  end
  describe '.authenticate_with_credentials' do
    before do
      User.create!(
        first_name: 'Han',
        last_name: 'Solo',
        email: 'millenium@falcon.net',
        password: 'easychewie',
        password_confirmation: 'easychewie'
      )
    end
    it 'should log in a user who enters valid credentials' do
      expect(User.authenticate_with_credentials('millenium@falcon.net', 'easychewie')).to be_truthy
    end
    it 'should reject login for a nonexistant e-mail' do
      expect(User.authenticate_with_credentials('tiefighter@empire.net', 'easychewie')).to be_nil
    end
    it 'should reject login for an incorrect password' do
      expect(User.authenticate_with_credentials('millenium@falcon.net', '34$ych3w1e')).to be_nil
    end
    it 'should allow login when there are spaces at the beginning or end of the email' do
      expect(User.authenticate_with_credentials('   millenium@falcon.net    ', 'easychewie')).to be_truthy
    end
    it 'should allow login no matter the case of the input e-mail' do
      expect(User.authenticate_with_credentials('MiLlEnIuM@FaLcOn.NeT', 'easychewie')).to be_truthy
    end


  end
end

