require 'spec_helper'

describe 'User Signup' do
	it "renders signup page successfully" do
    get '/signup'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Please Sign Up Below")
  end
end