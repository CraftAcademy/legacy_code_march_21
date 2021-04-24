RSpec.describe 'POST /api/analyses', type: :request do
  let(:clarifai_responce) do
    file_fixture('clarifai_safe_img.json').read
  end
  describe "Successful posts" do
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
  
      it 'is expected to return text resource' do
        expect(eval(JSON.parse(response.body)['reponse'])).to eq 'safe'
      end
    
      # it 'is expected to return clean text analysis' do
      #   expect(eval(JSON.parse(response.body)['results']['classifications'])["tag_name"]).to eq "safe"
      # end

      # it 'is expected to return confidence % of text analysis' do
      #   expect(eval(JSON.parse(response.body)['results']['classifications'])["confidence"]).to eq 0.968
      # end
    end
  end
end  