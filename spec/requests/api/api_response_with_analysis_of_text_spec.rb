require 'rails_helper'
RSpec.describe 'POST /api/analyses', type: :request do
  describe "Successful posts" do
    
    describe 'Clean text analysis' do

      before do
        post '/api/analyses', params: {
          analysis: {
            resource: 'Hello boo',
            category: 'text'
          }
        }
      end
  
      it 'is expected to resonse with 201' do
        expect(response).to have_http_status 201
      end
  
      it 'is expected to return text resource' do
        expect(JSON.parse(response.body)['results']['text']).to eq 'Hello boo'
      end
    
      it 'is expected to return clean text analysis' do
        expect(eval(JSON.parse(response.body)['results']['classifications'])[0]["tag_name"]).to eq "clean"
      end

      it 'is expected to return confidence % of text analysis' do
        expect(eval(JSON.parse(response.body)['results']['classifications'])[0]["confidence"]).to eq 0.968
      end
    end
  
    describe 'Profanity text analysis' do

      before do
        post '/api/analyses', params: {
          analysis: {
            resource: 'Fuck you boo',
            category: 'text'
          }
        }
      end
  
      it 'is expected to return text resource' do
        expect(JSON.parse(response.body)['results']['text']).to eq 'Fuck you boo'
      end
    
      it 'is expected to return profanity text analysis' do
        expect(eval(JSON.parse(response.body)['results']['classifications'])[0]["tag_name"]).to eq "profanity"
      end

      it 'is expected to return confidence % of text analysis' do
        expect(eval(JSON.parse(response.body)['results']['classifications'])[0]["confidence"]).to eq 0.96
      end
    end
  end

  describe "Unsuccessfull posts" do

    describe 'checks if resource is missing' do
      
      before do
        post '/api/analyses', params: {
          analysis: {
            resource: '', 
            category: 'text'
          }
        }
      end

      it 'is expected to resonse with 422' do
        expect(response).to have_http_status 422
      end

      it 'returns error message' do
        expected_output = "Resource can't be blank"
        expect(JSON.parse(response.body)[0]).to eq expected_output
      end

    end

    describe 'checks if category is missing' do
      
      before do
        post '/api/analyses', params: {
          analysis: {
            resource: 'hey boo', 
            category: ''
          }
        }
      end

      it 'is expected to resonse with 422' do
        expect(response).to have_http_status 422
      end

      it 'returns error message' do
        expected_output = "Category can't be blank"
        expect(JSON.parse(response.body)[0]).to eq expected_output
      end

    end
  end
end 