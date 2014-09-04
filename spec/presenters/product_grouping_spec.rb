require 'rails_helper'

describe 'ProductGrouping' do
  include UserSupport

  describe 'initialize' do
    before do
      Timecop.freeze

      create_user
    end

    after do
      Timecop.return
    end

    it 'should create a grouping of products' do
      products = [
        Product.create!(name: "ProductChase PG 1", \
          description: "ProductChase PG 2",
          link: "http://github.com/hf/productchase/PG1",
          user: @user,
          created_at: 1.minute.ago),

        Product.create!(name: "ProductChase PG 4", \
          description: "ProductChase PG 4",
          user: @user,
          link: "http://github.com/hf/productchase/PG4",
          created_at: 2.minutes.ago),

        Product.create!(name: "ProductChase PG 2", \
          description: "ProductChase PG 2",
          link: "http://github.com/hf/productchase/PG2",
          user: @user,
          created_at: 2.days.ago),

        Product.create!(name: "ProductChase PG 3", \
          description: "ProductChase PG 3",
          link: "http://github.com/hf/productchase/PG3",
          user: @user,
          created_at: 3.days.ago),
      ]

      expect(products).to eq products.sort_by { |p| p.created_at }.reverse

      grouping = ProductGrouping.new products

      expected_grouping = {
        Time.now.utc.midnight => [
          products[0],
          products[1]
        ],

        2.days.ago.midnight => [
          products[2]
        ],

        3.days.ago.midnight => [
          products[3]
        ]
      }

      grouping.each do |day, products|
        expect(expected_grouping).to have_key day

        expected_products = expected_grouping[day].sort_by { |p| p.votes.count }.reverse
        expect(expected_products).to eq products

        expected_grouping.delete day
      end

    end
  end
end
