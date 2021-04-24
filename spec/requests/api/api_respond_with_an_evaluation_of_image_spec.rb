RSpec.describe 'POST /api/analyses', type: :request do 
  let(:expected_response ) do
    file_fixture('clarifai.json').read
  end
  
  params = { analysis: {
    resource: "https://images.unsplash.com/photo-1606092195730-5d7b9af1efc5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
    category: "image"
    }}
  
  describe 'expected to receive a response for valid request ' do
      before do
        stub_request(:post, "https://api.clarifai.com/v2/models/d16f390eb32cad478c7ae150069bd2c6/outputs").
        to_return(status: 200, body: expected_response)
      post '/api/analyses', params: params
      end
   

      it 'is expected to respond 200' do 
        expect(response).to have_http_status 200
      end
  
      it 'is expected to respond with an evaluated output' do
        expect(JSON.parse(response.body)[:results]).to eq JSON.parse(expected_response)[:results]
      end
      
    end
  end