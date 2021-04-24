RSpec.describe 'POST /api/analyses', type: :request do
  let(:monkeylearn_responce) do
    file_fixture('missing_category.json').read
  end
  describe "Unsuccessfull posts" do
    
    describe 'missing resource' do
      before do       
          stub_request(:post, "https://api.monkeylearn.com/v3/classifiers/cl_KFXhoTdt/classify/").
          to_return(status: 422, body: monkeylearn_responce)
        post '/api/analyses', params: {
          analysis: {
            resource: 'Wah Ghwaan',
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