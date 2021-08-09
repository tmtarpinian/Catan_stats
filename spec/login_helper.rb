module LoginHelper

    def user_signup
        fill_in(:email, :with => "wilfred@wilfred.com")
        fill_in(:password, :with => "wilfred")
        click_button('Sign Up')
    end
  
    def user_login
        fill_in(:email, :with => "wilfred@wilfred.com")
        fill_in(:password, :with => "wilfred")
        click_button('Sign In')
    end
  end