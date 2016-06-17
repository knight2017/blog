require 'rails_helper'

RSpec.describe Post, type: :model do

   describe "validations" do
        it "needs a title" do
        a = Post.new
        a.valid?
        expect(a.errors).to have_key(:title)
        end
        it "at least 7 characters" do
         a = Post.new title: 'asdada'
         a.valid?
         expect(a.errors).to have_key(:title)
        end
        it "has a body" do
         a = Post.new title: 'asdada'
         a.valid?
         expect(a.errors).to have_key(:body)
        end
        it "snippets" do
          a = Post.new body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
          b = a.body_snippet
          expect(b.length).to eq(100)
        end








 end

end
