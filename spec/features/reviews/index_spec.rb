require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit the items show page" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @good_review = @chain.reviews.create(title: "I like this product", content: "This is a great product. I will buy it again soon.", rating: 5)
      @average_review = @chain.reviews.create(title: "So-so product", content: "This is okay.", rating: 3)
      @negative_review = @chain.reviews.create(title: "I don't like this product", content: "This is not a great product. I will not buy it again soon.", rating: 2)
      @terrible_review = @chain.reviews.create(title: "I hate it", content: "Never buy it again.", rating: 1)
    end

    it 'it shows reviews for an item' do

      visit "items/#{@chain.id}"

      within "#review-#{@good_review.id}" do
        expect(page).to have_content(@good_review.title)
        expect(page).to have_content(@good_review.content)
        expect(page).to have_css('span', :class => 'glyphicon-star')
      end
    end
  end
end
