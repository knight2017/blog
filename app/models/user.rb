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
    validates :last_name, presence: true
    validates :email, presence: true,
                      uniqueness: true,
                      format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    def full_name
      "#{first_name} #{last_name}"
    end


end
