require 'rails_helper'

describe User, :type => :model do
  include SanitationSupport
  include ValidationSupport

  describe 'validations' do
    it 'should require presence of uid' do
      validate_with_errors uid: nil
    end

    it 'should requrie presence of provider' do
      validate_with_errors provider: nil
    end

    it 'should require presence of name' do
      validate_with_errors name: nil
    end
  end

  describe 'sanitation' do
    it 'should strip whitespace from name' do
      sanitize_before_validation dirty: { name: ' ProductChase ' }, clean: { name: 'ProductChase' }
    end

    it 'should strip whitespace from twitter_username' do
      sanitize_before_validation dirty: { twitter_username: ' product_chase ' }, clean: { twitter_username: 'product_chase' }
    end

    it 'should not crash with a nil twitter_username' do
      sanitize_before_validation dirty: { twitter_username: nil }, clean: { twitter_username: nil }
    end
  end
end
