require 'rails_helper'

RSpec.feature "Existing user has items in cart" do
  scenario "they can place an order" do
    creature = FactoryGirl.create(:creature)
    user = User.create!(
      username: "Tom", 
      password: "password", 
      email: "tom@gmail.com"
    )
    
    visit root_path
    click_button "Sponsor me"
    visit '/cart'
    click_on "Login to Checkout"
  
    expect(current_path).to eq("/login")
    
    fill_in "session_username", with: "Tom"
    fill_in "session_password", with: "password"
    click_button "Login"
    
    expect(current_path).to eq('/cart')
  
    click_button "Checkout"
  
    expect(page).to have_content("Order was successfully placed")
    within('.table') do
      expect(page).to have_content(creature.name)
      expect(page).to have_content(creature.price)
      expect(page).to have_content(user.orders.first.total_price)
    end
    
    click_link "My Orders"  
    expect(current_path).to eq("/orders")
    expect(page).to_not have_content("Your cart is empty")
    expect(page).to have_content("Order 8")
  end
  
  scenario "they removed item in their cart and click checkout" do
    creature = FactoryGirl.create(:creature)
    user = User.create!(
      username: "Tom", 
      password: "password", 
      email: "tom@gmail.com"
    )
    
    visit root_path
    click_button "Sponsor me"
    visit '/cart'
    click_on "Login to Checkout"
        
    fill_in "session_username", with: "Tom"
    fill_in "session_password", with: "password"
    click_button "Login"
    
    click_button "-"
    click_button "Checkout"
    
    expect(page).to have_content("Your cart is empty")
    expect(current_path).to eq("/cart")
  end
end