require_relative "../spec_helper"
require "chartkick"

def app
  ApplicationController
end

describe app do
  it "renders root route successfully" do
    get '/'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Welcome to Catan Stats!")
  end
end
