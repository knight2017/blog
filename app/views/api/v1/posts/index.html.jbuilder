json.array! @blogs do |post|
  json.id post.id
  json.view_count  post.view_count
  json.title post.title
  json.created_at post.created_at.strftime("%Y-%B-%d")
  json.path api_v1_post_path(post)
  json.category post.category_name if post.category
  json.aauser do
    json.first_name post.aauser_first_name
    json.last_name  post.aauser_last_name
  end
  json.comments post.comments do |comment|
    json.id   comment.id
    json.body comment.body
  end
end
