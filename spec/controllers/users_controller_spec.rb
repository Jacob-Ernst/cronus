require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  user_hash = {email: 'much@test.doge', first_name: 'Create', last_name: 'User', password: 'test'}

  describe 'POST create' do
    # before unsaved_user = build(:user)


    context 'success' do
      before { post :create, user_hash }

      it 'sends status 201' do

        expect(response.status).to eq(201)

        decoded_body = JSON.parse(response.body)
        expect(decoded_body).not_to be_nil
      end

      it 'returns auth_token' do

        decoded_body = JSON.parse(response.body)

        expect(decoded_body["created_user"]["authentication_token"]).not_to be_nil
      end

      it 'creates a user' do
        expect(User.where(email: user_hash[:email])).not_to be_empty
      end
    end

    context 'provided incorrect parameters' do
      before { post :create, {} }

      it 'sends status 409' do
        expect(response.status).to eq(409)

        decoded_body = JSON.parse(response.body)
        expect(decoded_body).not_to be_nil
      end

      it 'returns an error' do
        decoded_body = JSON.parse(response.body)

        expect(decoded_body["error"]).not_to be_nil
      end
    end

    context 'user already exists' do
      before do
        create(:user)
        post :create, attributes_for(:user)
      end

      it 'sends status 409' do

        expect(response.status).to eq(409)

        decoded_body = JSON.parse(response.body)
        expect(decoded_body).not_to be_nil
      end

      it 'returns an error' do
        decoded_body = JSON.parse(response.body)

        expect(decoded_body["error"]).not_to be_nil
      end
    end
  end

  describe 'PUT update' do
    # before { AuthController.any_instance.stub(:authenticate).and_return true }

    context 'success' do

      it 'sends status 200' do
        # put :update, {}
      end

    end

  end

end
