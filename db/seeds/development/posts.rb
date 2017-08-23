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
##### h5
###### h6

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
    
![猫](https://s3-ap-northeast-1.amazonaws.com/age-blog/images/20170630_201153665.jpg "猫")

EOS

post = Post.new(
    title: 'markdown',
    body: markdown_text,
    posted_at: Time.now,
    status: Post::STATUS_PUBLIC
)
post.tag_list.add(TAGS)
post.save

markdown_text = <<'EOS'
Ruby on Railsを使って開発をしていると`bundle exec`や`bundle install`などのコマンドを当たり前のように使いますが、それらを提供しているBundlerの理解が曖昧だったためちょっと調べてみました。

## Bundlerとは？
- gemをプロジェクトごとに管理できる。
- 複数のPCで同一の環境を作ることができる。
- 依存関係のあるgemを一括でインストールできる。

そんなgemらしい。

## 使ってみる
### インストール

```
$ gem install bundler
```

### バージョンの確認

```
$ bundler -v
Bundler version 1.15.3
```

### Gemfileを生成する
gemのバージョンを指定するには **Gemfile**というファイルを使用する。
`bundle init`コマンドでGemfileをカレントディレクトリに生成できる。

```
$ bundle init
Writing new Gemfile to /Users/user/Practice/bundler_test/Gemfile
```

こんなのができる

```
$ cat Gemfile
# frozen_string_literal: true
source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"
```

### gemのインストール

今回はRailsのバージョンに4.2.1を指定してインストールする。

```
$ cat Gemfile
# frozen_string_literal: true
source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "rails", "4.2.1"
```

`bundle install`コマンドを実行する。
`--path`オプションを指定してgemをインストールするディレクトリを指定する。
ディレクトリはvendor/bundleを指定するのが慣習らしい。
これを指定しないとシステムにgemがインストールされてしまう。

```
$ bundle install --path vendor/bundle
Fetching gem metadata from https://rubygems.org/..........
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
Resolving dependencies...
Fetching rake 12.0.0
Installing rake 12.0.0
(省略)
Installing sprockets-rails 3.2.0
Fetching rails 4.2.1
Installing rails 4.2.1
Bundle complete! 1 Gemfile dependency, 35 gems now installed.
Bundled gems are installed into ./vendor/bundle.
```

インストール完了。この時、Railsと依存関係にあるgemについてもインストールされる。

この時点で **.bundle/config**と**Gemfile.lock**というファイルが生成される。

### .bundle/config
bundlerの設定が記述されている。
`BUILD_PATH: "vendor/bundle"`の記述によって、以降`bundle install`コマンドを実行する際に`--path`オプションを指定しなくても自動的にvendor/bundleディレクトリにgemがインストールされるようになる。

```
$ cat .bundle/config
---
BUNDLE_PATH: "vendor/bundle"
BUNDLE_DISABLE_SHARED_GEMS: "true"
```

### Gemfile.lock
gemの取得先、依存関係のあるgemのバージョンなどが記述されている。

```
$ cat Gemfile.lock
GEM
  remote: https://rubygems.org/
  specs:
    actionmailer (4.2.1)
      actionpack (= 4.2.1)
      actionview (= 4.2.1)
      activejob (= 4.2.1)
(省略)
    sprockets-rails (3.2.0)
      actionpack (>= 4.0)
      activesupport (>= 4.0)
      sprockets (>= 3.0.0)
    thor (0.20.0)
    thread_safe (0.3.6)
    tzinfo (1.2.3)
      thread_safe (~> 0.1)

PLATFORMS
  ruby

DEPENDENCIES
  rails (= 4.2.1)

BUNDLED WITH
   1.15.3
```

### Bundlerでインストールしたgemを使ってみる

`bundle exec`コマンドを使用することで、Bundlerによってインストールされたgemを使用してコマンドを実行できる。
試しにRailsのバージョンを確認してみる。

```
$ bundle exec rails -v
Rails 4.2.1
```

この状態で`bundle exec rails new <アプリケーション名>`を実行すると、BundlerによってインストールされたRailsのバージョンのアプリケーションを作成できる(今回はカレントディレクトリをアプリケーション名に指定)。また、Gemfileを上書きするかどうか確認されるので上書きをする。

```
$ bundle exec rails new .
       exist
      create  README.rdoc
      create  Rakefile
      create  config.ru
      create  .gitignore
    conflict  Gemfile
Overwrite /Users/user/Practice/bundler_test/Gemfile? (enter "h" for help) [Ynaqdh] y
       force  Gemfile
(省略)
Fetching jquery-rails 4.3.1
Installing jquery-rails 4.3.1
Using rails 4.2.1
Fetching sass-rails 5.0.6
Installing sass-rails 5.0.6
Fetching web-console 2.3.0
Installing web-console 2.3.0
Bundle complete! 12 Gemfile dependencies, 60 gems now installed.
Bundled gems are installed into ./vendor/bundle.
         run  bundle exec spring binstub --all
* bin/rake: spring inserted
* bin/rails: spring inserted
```

### インストール済みのgem一覧を表示する
`bundle list`コマンドを使用することでインストール済みgemの一覧を表示できる。

```
$ bundle list
Gems included by the bundle:
  * actionmailer (4.2.1)
  * actionpack (4.2.1)
  * actionview (4.2.1)
  * activejob (4.2.1)
  * activemodel (4.2.1)
  * activerecord (4.2.1)
(省略)
```

### gemをアップデートする
`bundle update`コマンドを使用してgemをアップデートする。
GemfileのRailsのバージョンを4.2.3に変更してから実行。

```
$ bundle update
Fetching gem metadata from https://rubygems.org/..........
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
Resolving dependencies...
Using rake 12.0.0
Using i18n 0.8.6
(省略)
Installing actionpack 4.2.3 (was 4.2.1)
Fetching actionmailer 4.2.3 (was 4.2.1)
Installing actionmailer 4.2.3 (was 4.2.1)
Fetching railties 4.2.3 (was 4.2.1)
Installing railties 4.2.3 (was 4.2.1)
Using sprockets-rails 3.2.0
Using coffee-rails 4.1.1
Using jquery-rails 4.3.1
Fetching rails 4.2.3 (was 4.2.1)
Installing rails 4.2.3 (was 4.2.1)
Using sass-rails 5.0.6
Using web-console 2.3.0
Bundle updated!
$ bundle exec rails -v
Rails 4.2.3
```

`bundle update`コマンドはGemfileを元にgemのインストールを行い、Gemfile.lockの更新も行うとのこと。

以上が基本的なBundlerの使用方法となる。

## 感想
Bundlerの基本だと思われることを調べてみましたが、まだまだ理解が甘いところがあります。Gemfile.lockはリポジトリに含めるべきかどうか、.bundle/configなどについてです。今度はもう少し細かい挙動や設定に焦点を当てて調べてみたいと思います。

## 参考にさせていただいたサイト
- [Bundler: The best way to manage a Ruby application's gems](http://bundler.io/)
- [Bundler概要 - Qiita](http://qiita.com/hisonl/items/162f70e612e8e96dba50)
- [【Ruby】bundlerの使い方 (Gem管理) - TASK NOTES](http://www.task-notes.com/entry/20141230/1419937660)
- [システムのgemにrailsをインストールせずrails newする - Qiita](http://qiita.com/youcune/items/222777415f00d19cccb4)

ありがとうございました。

EOS

post = Post.new(
    title: 'Bundlerについて調べてみた',
    body: markdown_text,
    posted_at: Time.now,
    status: Post::STATUS_PUBLIC
)
post.tag_list.add(TAGS)
post.save