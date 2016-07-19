class Post < ActiveRecord::Base
belongs_to :user
belongs_to :category
has_many :comments, dependent: :destroy
has_many :favourites, dependent: :destroy
has_many :users, through: :favourites
has_many :stars, dependent: :destroy
has_many :staring_users, through: :stars, source: :user
has_many :taggings, dependent: :destroy
has_many :tags, through: :taggings
extend FriendlyId
friendly_id :title, use: [:slugged, :finders, :history]
mount_uploader :image, AvatarUploader


validates(:title, presence: true, uniqueness: true, length: {minimum: 2})
validates :body, presence: true, length: {minimum: 2}

def self.search(str)
  where("title @@ :q OR body @@ :q", q: str)
end

 def body_snippet
   body.truncate(100)
 end

 def new_first_comment
 comments.order(id: :desc)
 end

def faved_by(user)
  favourites.exists?(user:user)
end
def fave_for(user)
 favourites.find_by_user_id user
end
def stared_by?(user)
  stars.exists?(user:user)
end
def star_for(user)
 stars.find_by_user_id user
end

end
