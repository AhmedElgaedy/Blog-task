# Create Users
user1 = User.find_or_create_by!(email: 'user1@example.com') do |user|
  user.name = 'User One'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.image = 'user1_image_url'
end

user2 = User.find_or_create_by!(email: 'user2@example.com') do |user|
  user.name = 'User Two'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.image = 'user2_image_url'
end

# Create Posts
post1 = Post.find_or_create_by!(title: 'First Post', author: user1) do |post|
  post.body = 'This is the body of the first post.'
  post.tags = [ 'tag1', 'tag2' ]
end

post2 = Post.find_or_create_by!(title: 'Second Post', author: user2) do |post|
  post.body = 'This is the body of the second post.'
  post.tags = [ 'tag3', 'tag4' ]
end

# Create Comments
Comment.find_or_create_by!(post: post1, user: user2) do |comment|
  comment.body = 'This is a comment on the first post by user2.'
end

Comment.find_or_create_by!(post: post2, user: user1) do |comment|
  comment.body = 'This is a comment on the second post by user1.'
end
