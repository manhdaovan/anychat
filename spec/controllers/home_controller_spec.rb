require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'POST #login' do
    context 'with new user option and no existing user' do
      it 'create user success with valid info' do
        post 'login', params: {user: {username:              'testuser',
                                      password:              'testuserpassword',
                                      password_confirmation: 'testuserpassword',
                                      is_new:                1}}

        expect(response).to have_http_status :redirect
        expect(assigns(:user).errors.present?).to eq false
      end
    end

    context 'with new user option and existing user' do
      let!(:user) { FactoryGirl.create(:user, username: 'testuser') }
      it 'create user fail' do
        post 'login', params: {user: {username:              'testuser',
                                      password:              'testuserpassword',
                                      password_confirmation: 'testuserpassword',
                                      is_new:                1}}

        expect(response).to render_template :index
        expect(assigns(:user).errors.present?).to eq true
        expect(assigns(:user).errors.full_messages.include?('Username has already been taken')).to eq true
      end
    end

    context 'with existing user option and valid info' do
      let!(:user) { FactoryGirl.create(:user, username: 'testuser', password: 'testuserpassword') }
      it 'login success' do
        post 'login', params: {user: {username: 'testuser',
                                      password: 'testuserpassword'}}

        expect(response).to have_http_status :redirect
        expect(assigns(:user).errors.present?).to eq false
      end
    end
  end
end
