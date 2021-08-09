require_relative "../spec_helper"

describe ApplicationController do
  
  describe app do
    it "renders root route successfully" do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Catan Stats!")
    end
  end
end