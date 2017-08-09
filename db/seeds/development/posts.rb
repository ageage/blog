number_of_posts = 50

TAGS = [['プログラミング', 'Rails', 'Ruby'], ['日常', '筋トレ'], ['日常', 'コーヒー']]

number_of_posts.times do |i|
  post = Post.new(
      title: "タイトル : #{i}",
      body: "記事 : #{i}"*400,
      posted_at: Time.now,
      status: Post::STATUS_VALUES[i % Post::STATUS_VALUES.length]
  )
  post.tag_list.add(TAGS[i%3])
  post.save
end


markdown_text = <<EOS
# h1
## h2
### h3
#### h4

段落

改行(末尾スペース２つあり)  
改行

*イタリック*
_イタリック_
**ボールド**
__ボールド__
___イタリック＆ボールド___
***イタリック＆ボールド***

横罫線`***`
***
横罫線`___`
___

|aaaaaaaaaa|bbbbbbbbbb|cccccccccc|
|:--|:--:|--:|
|left|center|right|
|left|center|right|
|left|center|right|
|left|center|right|
|left|center|right|

- 非序列リスト
  - 非序列リスト(入れ子)
  - 非序列リスト(入れ子)
  - 非序列リスト(入れ子)
- 非序列リスト
  - 非序列リスト(入れ子)
  - 非序列リスト(入れ子)
- 非序列リスト
  - 非序列リスト(入れ子)
- 非序列リスト

1. 序列リスト
 1. 序列リスト(入れ子)
 1. 序列リスト(入れ子)
 1. 序列リスト(入れ子)
2. 序列リスト
 1. 序列リスト(入れ子)
 1. 序列リスト(入れ子)
3. 序列リスト
 1. 序列リスト(入れ子)
4. 序列リスト

[リンク:GitHub](http://github.com)

> 引用
> 引用
>> 多重引用

インラインコード`git push -u origin master` です。

Ruby

```ruby
# ruby
puts 'Hello, World!!'
```

JavaScript

```javascript
// JavaScript
console.log('Hello, World!!');
```

C++

```cpp
int main(void) {
  // C++
  std::cout << "Hello, World!!" << std::endl;
}
```

EOS

post = Post.new(
    title: 'markdown',
    body: markdown_text,
    posted_at: Time.now,
    status: Post::STATUS_PUBLIC
)
post.tag_list.add(TAGS[0])
post.save
