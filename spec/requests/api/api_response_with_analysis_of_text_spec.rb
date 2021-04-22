RSpec.describe 'POST /api/analyses', type: :request do
  describe 'Clean text analysis' do
    before do
      post '/api/analyses', params: {
        analysis: {
          resource: 'Hello boo',
          category: 'text'
        }
      }
    end

    it 'is expected to resonse with 200' do
      expect(response).to have_http_status 200
    end
  end
end 