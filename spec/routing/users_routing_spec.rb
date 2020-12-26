require 'spec_helper'

describe 'User Signup' do
	it "renders signup page successfully" do
		visit '/signup'
		expect(page.status_code).to eq(200)
  end
end