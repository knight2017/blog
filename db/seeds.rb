
  # 500.times do
  #
  #  q =  Post.create  title: Faker::Name.title,
  #                    body:  Faker::ChuckNorris.fact
  #
  #  5.times { q.comments.create body: Faker::ChuckNorris.fact} if q.persisted?
  #
  # end
  #
  # ['Sports', 'Art', 'Cats', "Tech", 'News', 'Like', 'Hate','Home','School','Unlike'].each do |cat|
  # Category.create title: cat
  # end

   100.times do
    q = Post.first
    q.destroy
   end

  puts Cowsay.say "500 inputs done!!"
