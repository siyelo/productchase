class User < ActiveRecord::Base
  before_create{twitter_username.downcase!}

  has_many :products
  has_many :votes
  has_many :vote_products, through: :votes, source: :product

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :omniauthable

  validates :name, presence: true

  validates :uid, presence: true
  validates :provider, presence: true

  validates :uid, uniqueness: { scope: :provider, case_insensitive: true }

  validates :twitter_username, uniqueness: { case_insensitive: true }, presence: true

  def self.find_or_create_for_oauth auth
    user = User.find_by uid: auth.uid, provider: auth.provider
    return user unless user.nil?

    user = User.create! uid: auth.uid, \
      provider: auth.provider,
      password: Devise.friendly_token,
      name: auth.extra.raw_info.name,
      twitter_username: auth.extra.raw_info.screen_name,
      twitter_pic: auth.extra.raw_info.profile_image_url_https
  end

  def name= name
    write_attribute :name, name.strip if name.respond_to? :strip
  end

  def twitter_username= username
    write_attribute :twitter_username, username.strip if username.respond_to? :strip
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def voted?(product)
    votes.find_by(product: product)
  end

  def to_param
    twitter_username
  end
end
