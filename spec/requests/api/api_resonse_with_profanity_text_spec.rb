RSpec.describe 'POST /api/analyses', type: :request do
  let(:monkeylearn_responce) do
    file_fixture('profanity_text.json').read
  end
  
  describe 'Profanity text analysis' do
    before do       
        stub_request(:post, "https://api.monkeylearn.com/v3/classifiers/cl_KFXhoTdt/classify/").
        to_return(status: 200, body: monkeylearn_responce)
      post '/api/analyses', params: {
        analysis: {
          resource: 'Hello boo',
          category: 'text'
        }
      }
    end

    it 'is expected to return text resource' do
      expect(JSON.parse(response.body)['results']['text']).to eq 'Fuck you boo'
    end

    it 'is expected to return profanity text analysis' do
      expect(eval(JSON.parse(response.body)['results']['classifications'])["tag_name"]).to eq "profanity"
    end

    it 'is expected to return confidence % of text analysis' do
      expect(eval(JSON.parse(response.body)['results']['classifications'])["confidence"]).to eq 0.96
    end
  end
end




  

