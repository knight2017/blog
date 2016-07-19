class User < ActiveRecord::Base
  has_many :stars, dependent: :destroy
  has_many :stared_posts, through: :stars, source: :post
  has_many :posts, dependent: :destroy
  has_many :comments,  dependent: :nullify
  has_many :favourites, dependent: :destroy
  has_many :fav_posts, through: :favourites, source: :post
  has_secure_password

  attr_accessor :current_password
  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :using_oauth?
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, unless: :using_oauth?
  validates :uid, uniqueness: {scope: :provider}, if: :using_oauth?
  serialize :twitter_raw_data, Hash
  PROVIDER_TWITTER = "twitter"
  def using_oauth?
    uid.present? && provider.present?
  end
  def using_twitter?
    using_oauth? && provider == PROVIDER_TWITTER
  end
  def full_name
      "#{first_name} #{last_name}"
  end
  def self.create_from_twitter(twitter_data)
    user = User.new
    full_name = twitter_data["info"]["name"].split(" ")
    user.first_name       = full_name.first
    user.last_name        = full_name.last
    user.uid              = twitter_data["uid"]
    user.provider         = twitter_data["provider"]
    user.twitter_consumer_token    = twitter_data["credentials"]["token"]
    user.twitter_consumer_secret   = twitter_data["credentials"]["secret"]
    user.twitter_raw_data = twitter_data
    user.password         = SecureRandom.urlsafe_base64
    user.save!
    user
  end

  def self.find_or_create_from_twitter(twitter_data)
    user = User.where(uid: twitter_data["uid"], provider: twitter_data["provider"]).first
    user = create_from_twitter(twitter_data) unless user
    user

  end

end
