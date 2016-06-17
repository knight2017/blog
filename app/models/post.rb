class Post < ActiveRecord::Base
belongs_to :user
belongs_to :category
has_many :comments, dependent: :destroy
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





end
