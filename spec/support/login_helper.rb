module LoginHelper

    def user_signup
      fill_in("name", :with => "david")
      fill_in("email", :with => "david@david.com")
      fill_in("password", :with => "david")
      click_button('Submit')
    end
  
    def user_login
      fill_in("email", :with => "david@david.com")
      fill_in("password", :with => "david")
      click_button('Submit')
    end
  
    def create_standard_user 
      @mdavid = User.create(
        name: "David",
        email: "david@david.com",
        password: "david"
        )
    end
    
  end