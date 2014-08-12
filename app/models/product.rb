require 'uri'

# Validates a Product's link.
# Sadly, format validation does not work correctly for invalid URLs.
class LinkValidator < ActiveModel::Validator
  def validate record
    begin
      uri = URI.parse record.link
      record.errors[:link] << 'URL is not HTTP/HTTPS.' unless uri.scheme =~ /\Ahttps?\z/i
    rescue URI::InvalidURIError
      record.errors[:link] << 'URL is not valid.'
    end
  end
end

class Product < ActiveRecord::Base
  validates :link, presence: true

  validates_with LinkValidator

  validates :link, uniqueness: {
    message: 'Product with that link already exists.'
  }

  validates :name, presence: true

  validates :name, length: {
    minimum: 1,
    maximum: 25,
    too_short: 'Name is too short. At least %{count} characters are required.',
    too_long:  'Name is too long. Up to %{count} characters allowed.'
  }

  validates :description, length: {
    maximum: 60,
    too_long: 'Description is too long. Up to %{count} characters allowed.'
  }

  def name= name
    write_attribute :name, name.strip if name.respond_to? :strip
  end

  def description= description
    write_attribute :description, description.strip if description.respond_to? :strip
  end

  def link= link
    write_attribute :link, sanitize(link)
  end

  protected

  # Cleans up a link from needless (and potentially dangerous) data, such as
  # usernames, passwords, ports, fragments, query strings. Also normalizes
  # strings so uniqueness can be observed.
  def sanitize link
    begin
      uri = URI.parse link
      %w{ fragment query user password userinfo port }.each { |p| uri.send "#{p}=", nil }

      return uri.normalize.to_s
    rescue URI::InvalidURIError
      # do nothing
    end

    link
  end
end
