number_of_posts = 50

STATUS_VALUES = %w(private public)
TAGS = [['プログラミング', 'Rails', 'Ruby'], ['日常','筋トレ'], ['日常', 'コーヒー']]

number_of_posts.times do |i|
  post = Post.new(
      title: "タイトル : #{i}",
      body: "記事 : #{i}"*400,
      posted_at: Time.now,
      status: STATUS_VALUES[i % STATUS_VALUES.length]
  )
  post.tag_list.add(TAGS[i%3])
  post.save
end