require 'spec_helper'

describe 'User Controller', type: :feature do
	it "renders signup page successfully" do
		visit '/signup'
		expect(page.status_code).to eq(200)
  end
end