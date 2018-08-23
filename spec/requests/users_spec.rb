require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:users) { FactoryBot.create_list(:user, 10) }

    describe 'GET /users/index' do
        before { get '/users/index' }

        it 'returns users' do
            expect(json(response.body)).not_to be_empty
            expect(json(response.body).size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
end