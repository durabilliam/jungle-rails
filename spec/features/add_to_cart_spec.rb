require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
  
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  
  scenario "User can add items to cart" do
    visit root_path
    #save_screenshot
    #puts page.html
    expect(page).to have_text 'My Cart (0)'
    first('button').click
    sleep(1)
  
    #save_screenshot
    expect(page).to have_text 'My Cart (1)'
  end



end
