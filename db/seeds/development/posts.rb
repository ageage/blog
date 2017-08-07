number_of_posts = 50

STATUS_VALUES = %w(draft public)

number_of_posts.times do |i|
  Post.create(
      title: "タイトル : #{i}",
      body: "記事 : #{i}"*100,
      posted_at: Time.now,
      status: STATUS_VALUES[i % STATUS_VALUES.length]
  )
end