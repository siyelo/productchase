require 'rails_helper'

describe ProductsController, :type => :controller do
  include ProductSupport

  describe 'create' do
    before :all do
      @params =  {
          product: {
            link: 'http://github.com/hf/productchase',
            name: 'ProductChase',
            description: 'Recursion. Funny.'
        }
      }
    end

    it 'should create new product' do
      post :create, @params

      product = assigns(:product)

      expect(product.name).to eq @params[:product][:name]
      expect(product.link).to eq @params[:product][:link]
      expect(product.description).to eq @params[:product][:description]
      expect(product.persisted?).to be true

      expect(response).to redirect_to product_path(assigns(:product))
    end

    it 'should not create a new product' do
      @params[:product][:link] = ''

      post :create, @params

      expect(assigns(:product).persisted?).to be false
      expect(response).to render_template 'new'
    end
  end

  describe 'show' do
    before(:each) { create_product }

    it 'should show a product' do
      get :show, { id: @product.id }

      expect(assigns(:product)).to eq @product
      expect(response).to render_template 'show'
    end

    it 'should not show a product' do
      get :show, { id: @product.id + 1000 }

      expect(assigns(:product)).to be_falsy
      expect(response).to have_http_status 404
    end
  end

  describe 'edit' do
    before(:each) { create_product }

    it 'should edit a product' do
      get :edit, { id: @product.id }

      expect(assigns(:product)).to eq @product
      expect(response).to render_template 'edit'
    end

    it 'should not edit a product' do
      get :edit, { id: @product.id + 1000 }

      expect(assigns(:product)).to be_falsy
      expect(response).to have_http_status 404
    end
  end

  describe 'update' do
    before(:each) { create_product }

    it 'should update a product' do
      @product.name = 'Updated Product Name'

      post :update, { id: @product.id, product: @product.attributes }

      product = assigns(:product)

      expect(product.persisted?).to be true
      expect(product.name).to eq @product.name

      expect(response).to redirect_to product_path(@product)
    end

    it 'should not update a product due to non-existence' do
      post :update, { id: @product.id + 1000, product: @product.attributes }

      expect(assigns(:product)).to be_falsy
      expect(response).to have_http_status 404
    end

    it 'should not update a product due to link uniqueness' do
      another_product = Product.create! link: 'http://siyelo.com', name: 'Siyelo'

      @product.link = another_product.link

      post :update, { id: @product.id, product: @product.attributes }

      product = assigns(:product)

      @product.reload

      expect(product).to eq @product
      expect(product.changed?).to be true
      expect(response).to render_template 'edit'
    end
  end

  describe 'destroy' do
    before(:each) { create_product }

    it 'should delete an existing product' do
      delete :destroy, { id: @product.id }

      expect(assigns(:product).persisted?).to be false
      expect(response).to redirect_to products_path
    end

    it 'should not delete a non-existing product' do
      delete :destroy, { id: @product.id + 1000 }

      expect(assigns(:product)).to be_falsy
      expect(response).to have_http_status 404
    end
  end
end
