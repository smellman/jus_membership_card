# 日本UNIXユーザ会会員証自動生成プログラム

## setup

- ruby 2.7.3をインストールしておくこと

```sh
bundle install
```

## 使い方

プログラムを書くか、直接irbなどで叩く

```sh
ruby membership_card.rb hogehoge.pdf 008080 12001R 2021/05/31 "松澤太郎" "Taro Matsuzawa"
```

## docker build

```sh
docker build . -t smellman/jus-membership-card
```

## docker

```sh
docker run --rm -v $(pwd):/output -it smellman/jus-membership-card /output/12009R.pdf 008080 12001R 2021/05/31 "松澤太郎" "Taro Matsuzawa"
```