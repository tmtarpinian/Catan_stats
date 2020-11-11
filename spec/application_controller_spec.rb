require_relative "spec_helper"

def app
  ApplicationController
end

describe ApplicationController do
 
  describe "Homepage" do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Catan")
    end
  end
end
