
RSpec.describe 'POST /api/analyses', type: :request do 
let(:expected_response) do
  file_fixture('monkey_learn.json').read
end

params = { analysis: {
  resource: "Hello my friend",
  category: "text"
  }}

describe 'expected to receive a response for valid request ' do
    before do
      stub_request(:post, "https://api.monkeylearn.com/v3/classifiers/cl_KFXhoTdt/classify/").
         to_return(status: 200, body: expected_response)
      post '/api/analyses', params: params
    end
 
    it 'is expected to respond with 200' do
      expect(response).to have_http_status 200
    end

    it 'is expected to respond with the classifications from the stub' do
      response_json = (JSON.parse(response.body))
      expect(eval(response_json['results']['classifications'])).to eq JSON.parse(expected_response)[0]['classifications']
    end

    it 'is expected to respond with the tag of clean' do
      response_json = (JSON.parse(response.body))
      expect(eval(response_json['results']['classifications'])[0]['tag_name']).to eq 'clean'
    
    end

    it 'is expected to respond with a confidence rating' do
      response_json = (JSON.parse(response.body))
      evaluation = (eval(response_json['results']['classifications']))
      expect(evaluation[0]['confidence']).to be > 0.90
    end
  end
end