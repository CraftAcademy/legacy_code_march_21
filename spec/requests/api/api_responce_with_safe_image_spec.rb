RSpec.describe 'POST /api/analyses', type: :request do
  let(:clarifai_responce) do
    file_fixture('clarifai_safe_img.json').read
  end

  let(:safe_responce) do
    file_fixture('safe_img_answers.json').read
  end


  describe 'safe image analysis' do
    params = {
      analysis: {
        resource: "https://jagareforbundet.se/contentassets/aae640fff6af4360a9a1e9e9de8f0bc1/9414399-brunbjorn_red.jpg",
        category: "image"
      }
    }
    before do       
      stub_request(:post, "https://api.clarifai.com/v2/models/d16f390eb32cad478c7ae150069bd2c6/outputs")
      .to_return(status: 200, body: clarifai_responce)
      post '/api/analyses', params: params
    end

    it 'is expected to resonse with 200' do
      expect(response).to have_http_status 200
    end
  
    it 'is expected to return safe image responce' do
      expect(JSON.parse(response.body)['results']).to eq JSON.parse(safe_responce)
    end
  end
end  