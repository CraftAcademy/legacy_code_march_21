RSpec.describe 'POST /api/analyses', type: :request do
  
  let(:clarifai_responce) do
    file_fixture('clarifai_api_response.json').read
  end

  let(:expected_results) do
    file_fixture('image_moderation_results.json').read
  end

  describe 'receives response for correct request' do
    
    params = {
      analysis: {
        resource: "https://empire-s3-production.bobvila.com/articles/wp-content/uploads/2020/06/Types-of-Palm-Trees.jpg", 
        category: "image"
      }
    }

    before do        
      stub_request(:post, "https://api.clarifai.com/v2/models/d16f390eb32cad478c7ae150069bd2c6/outputs")
      .to_return(status: 200, body: clarifai_responce )
      post '/api/analyses', params: params 
    end

    it 'is expected to respond 200' do
      expect(response).to have_http_status 200
    end
   
    it 'it shows image moderation results' do
      expect(JSON.parse(response.body)[:results]).to eq JSON.parse(expected_results)[:results]
    end
  end
end