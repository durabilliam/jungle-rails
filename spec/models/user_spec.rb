require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a user with same password and password confirmation' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: "no@ohoh.com", password: "12341234", password_confirmation: "12341234")
      expect(@user).to be_valid
    end

    it 'should not create a user with different password and password confirmation' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: "no@ohoh.com", password: "12341234", password_confirmation: "12344321")
      expect(@user).to_not be_valid
    end

    it 'should not create a user with no password and no password confirmation' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: "no@ohoh.com", password: nil, password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it 'should not create a user if the email already exists (Case Sensitive)' do
      @user1 = User.create(firstname: "Willi", lastname: "Makeit", email: "TEST@TEST.com", password: "12341234", password_confirmation: "12341234")
      @user2 = User.create(firstname: "Willi", lastname: "Makeit", email: "test@test.com", password: "12341234", password_confirmation: "12341234")
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
    end

    it 'should not create a user if no email)' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: nil, password: "12341234", password_confirmation: "12341234")
      expect(@user).to_not be_valid
    end

    it 'should not create a user if no firstname)' do
      @user = User.create(firstname: nil, lastname: "Makeit", email: "no@ohoh.com", password: "12341234", password_confirmation: "12341234")
      expect(@user).to_not be_valid
    end   
    
    it 'should not create a user if no lastname)' do
      @user = User.create(firstname: "Willi", lastname: nil, email: "no@ohoh.com", password: "12341234", password_confirmation: "12341234")
      expect(@user).to_not be_valid
    end

    it 'should not create a user if password is less than 8 characters)' do
      @user = User.create(firstname: "Willi", lastname: nil, email: "no@ohoh.com", password: "1234123", password_confirmation: "1234123")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user if successfully authenticated)' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: "no@ohoh.com", password: "12341234", password_confirmation: "12341234")
      @user1 = User.authenticate_with_credentials("no@ohoh.com", "12341234")
      expect(@user1.firstname).to eq("Willi")
      expect(@user1.lastname).to eq("Makeit")
    end

    it 'should return a user if successfully authenticated with uppercase-email)' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: "no@ohoh.com", password: "12341234", password_confirmation: "12341234")
      @user1 = User.authenticate_with_credentials("NO@OHOH.COM", "12341234")
      expect(@user1.firstname).to eq("Willi")
      expect(@user1.lastname).to eq("Makeit")
    end

    it 'should return a user if successfully authenticated with lowercase-email)' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: "eXample@domain.COM", password: "12341234", password_confirmation: "12341234")
      @user1 = User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", "12341234")
      expect(@user1.firstname).to eq("Willi")
      expect(@user1.lastname).to eq("Makeit")
    end

    it 'should return a user if successfully authenticated with whitespaces in email)' do
      @user = User.create(firstname: "Willi", lastname: "Makeit", email: "no@ohoh.com", password: "12341234", password_confirmation: "12341234")
      @user1 = User.authenticate_with_credentials("  no@ohoh.com  ", "12341234")
      expect(@user1.firstname).to eq("Willi")
      expect(@user1.lastname).to eq("Makeit")
    end

  end

end
