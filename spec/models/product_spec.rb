require 'uri'
require 'rails_helper'

describe Product, :type => :model do
  include UserSupport
  include ProductSupport
  include ValidationSupport
  include SanitationSupport

  it { should validate_presence_of :link }
  it { should validate_presence_of :name }

  describe 'validations' do
    it 'should not allow invalid HTTP/HTTPS links' do
      validate_with_errors link: 'http://!invalid!.com'
    end

    it 'should allow valid HTTP/HTTPS links' do
      validate_without_errors link: 'HtTp://example.com'
    end

    it 'should not allow short names' do
      validate_with_errors name: ''
    end

    it 'should not allow huge names' do
      validate_with_errors name: 'P' * 26
    end

    it 'should allow long-enough names' do
      validate_without_errors name: 'P' * 25
    end

    it 'should not allow a huge description' do
      validate_with_errors description: 'P' * 61
    end

    it 'should allow a reasonable description' do
      validate_without_errors description: 'P' * 60
    end

    it 'should not allow a userless product' do
      validate_with_errors user: nil
    end

    it 'should not allow a product with an invalid user' do
      create_user

      @user.password = 'pswd'

      validate_with_errors user: @user
    end

    it 'should allow a product with a valid user' do
      create_user
      validate_without_errors user: @user
    end
  end

  describe 'sanitation' do
    it 'should sanitize names, links, descriptions' do
      sanitize_before_validation \
        dirty: {
          name: ' ProductChase ',
          link: ' HtTP://uripasswords:suck@goOgLe.COM:8080/path#hello?test=ing&what=ever/ ',
          description: ' A truly lovely product. '},
        clean: {
          name: 'ProductChase',
          link: 'http://google.com/path',
          description: 'A truly lovely product.' }
    end
  end
end
