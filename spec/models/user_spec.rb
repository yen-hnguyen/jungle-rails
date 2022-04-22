require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be created with the required fields' do
      @user = User.new({
        first_name: "Yen",
        last_name: "Nguyen",
        email: "test@hotmail.com",
        password: "12345",
        password_confirmation: "12345"
      })
      expect(@user).to be_valid
    end

    it 'should have a valid first name' do
      @user = User.new({
        first_name: nil,
        last_name: "Nguyen",
        email: "test@hotmail.com",
        password: "12345",
        password_confirmation: "12345"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'should have a valid last name' do
      @user = User.new({
        first_name: "Yen",
        last_name: nil,
        email: "test@hotmail..com",
        password: "12345",
        password_confirmation: "12345"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'should have a valid email' do
      @user = User.new({
        first_name: "Yen",
        last_name: "Nguyen",
        email: nil,
        password: "12345",
        password_confirmation: "12345"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'should have a valid email' do
      @user = User.new({
        first_name: "Yen",
        last_name: "Nguyen",
        email: "test@email.com",
        password: nil,
        password_confirmation: nil
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'should have password and password confirmation matched' do
      @user = User.new({
        first_name: "Yen",
        last_name: "Nguyen",
        email: "test@email.com",
        password: "12345",
        password_confirmation: "123456"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    describe 'emails must be unique' do
      before(:all) do 
        @user = User.create({
          first_name: "Yen",
          last_name: "Nguyen",
          email: "test1@email.com",
          password: "12345",
          password_confirmation: "12345"
        })
      end 

      it 'should not create with the same email' do
        @user2 = User.new({
          first_name: "Yen",
          last_name: "Nguyen",
          email: "test1@email.COM",
          password: "12345",
          password_confirmation: "12345"
        })
        expect(@user2).to_not be_valid
        expect(@user2.errors.full_messages).to include "Email has already been taken"
      end
    end

    it 'should have the password length minimum of 5' do
      @user = User.new({
        first_name: "Yen",
        last_name: "Nguyen",
        email: "test@hotmail.com",
        password: "123",
        password_confirmation: "123"
      })
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end 
  end

  describe '.authenticate_with_credentials' do   
    before(:all) do
      @user = User.create({
        first_name: "Yen",
        last_name: "Nguyen",
        email: "test123@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      })
    end 

    it 'should authenticate with the right credentails' do
      email = "test123@gmail.com"
      password = 123456789
      @user2 = User.authenticate_with_credentials(email, password)

      expect(@user2).not_to be_nil
    end

    it 'should authenticate if there is spaces before and/or after the email ' do
      email = " test123@gmail.com     "
      password = 123456789
      @user2 = User.authenticate_with_credentials(email, password)

      expect(@user2).not_to be_nil
    end

    it 'should authenticate if user types in the wrong case for their email' do
      email = "TEST123@gmail.CoM"
      password = 123456789
      @user2 = User.authenticate_with_credentials(email, password)

      expect(@user2).not_to be_nil
    end
    
  end  
end
