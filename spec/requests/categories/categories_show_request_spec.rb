require 'spec_helper'

describe "Categories Show Requests" do
  context "category" do
    let!(:categories) do
      10.times {Fabricate(:category)}
    end
    let!(:products) do
      10.times {Fabricate(:product)}
    end
    let!(:product_categories) do
      [p_c_one = Fabricate(:product_category,
                           :product_id => 1,
                           :category_id => 1),
       p_c_two = Fabricate(:product_category,
                           :product_id => 2,
                           :category_id => 1),
       p_c_three = Fabricate(:product_category,
                             :product_id => 3,
                             :category_id => 1),
       p_c_four = Fabricate(:product_category,
                            :product_id => 4,
                            :category_id => 1),
       p_c_five = Fabricate(:product_category,
                            :product_id => 1,
                            :category_id => 2),
      ]
    end

    let!(:inactive_product) { Fabricate(:product, :retired => true) }

    before(:each) do
      visit "/categories/1"
    end

    it "lists the products for the category" do
      category = Category.find(1)
      category.products.each do |product|
        #product = Product.find_by_id(product_category.product_id)
        page.should have_link(product.title, :href => product_path(product))
      end
    end

    it "doesn't list retired products for a category" do
      category = Category.find(1)
      category.products << inactive_product
      category.save
      visit "/categories/1"
      page.should_not have_content(inactive_product.title)
    end


  end
end
