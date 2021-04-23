RSpec.describe 'POST /api/analyses', type: :request do
  
  let(:monkeylearn_response) do
    file_fixture('monkeylearn_api_response.json').read
  end

  let(:expected_results) do
    file_fixture('text_moderation_results.json').read
  end

  describe 'receives response for correct request' do
    
    params = { 
       analysis: {
          resource: "Have a nice day kind sir",
          category: "text"
        }
    }

    before do        
      stub_request(:post, "https://api.monkeylearn.com/v3/classifiers/cl_KFXhoTdt/classify/")
      .to_return(status: 200, body: monkeylearn_response)
      post '/api/analyses', params: params 
    end

    it 'is expected to respond 200' do
      expect(response).to have_http_status 200
    end
   
    it 'it shows text moderation results' do       
      expect(eval(JSON.parse(response.body)["results"]["classifications"])).to eq JSON.parse(expected_results)["classifications"][0]
    end
  end
end