require 'rails_helper'

RSpec.describe "Review Edit Page" do
  describe "When I visit the edit review page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @good_review = @chain.reviews.create(title: "I like this product", content: "This is a great product. I will buy it again soon.", rating: 5)
    end

  it 'I can see the prepopulated fields of that item' do
    visit "/items/#{@chain.id}"

    within "#review-#{@good_review.id}" do
      click_on "Edit review"
    end

    expect(current_path).to eq("/items/#{@chain.id}/#{@good_review.id}/edit")

    expect(find_field('Title').value).to eq "I like this product"
    expect(find_field('Content').value).to eq "This is a great product. I will buy it again soon."
    expect(find_field('Rating').value).to eq "5"
  end
end
end