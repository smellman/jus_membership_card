# 日本UNIXユーザ会会員証自動生成プログラム

## setup

- rubyをインストールしておくこと
- jusのロゴは入手しておくこと

```
gem install bundle
bundle install
cp (どこか) JUS.png
```

## 使い方

プログラムを書くか、直接irbなどで叩く

```ruby
require './membership_card.rb'

generate_membership_card("008080", "DUMMY", "2018-05-31", "松澤 太郎(組長)", "Taro Matsuzawa", "hogehoge")
```
