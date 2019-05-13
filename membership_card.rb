# coding: utf-8
require "prawn"
require "prawn/measurement_extensions"

# クレジットカードサイズ
CARD_SIZE = [85.60.send(:mm), 53.98.send(:mm)]

def generate_membership_card(filepath, color, member_no, expired_date, name_ja, name_en, password)
  Prawn::Document.generate(filepath, :page_size => CARD_SIZE, :margin => 0) do
    fill_color color
    stroke do
      fill { rectangle [0, CARD_SIZE[1]], CARD_SIZE[0], 16.send(:mm)}
    end
    # 以下グラデーションっぽいのを試したがうまく行かなかった
    # base_height = 1.to_f
    # _line_height = base_height
    # _padding = (1/22.0)
    # base_y = (53.98 - 16.5).to_f
    # _y = base_y
    # (0..22).each do |i|
    #   p _y
    #   stroke do
    #     fill { rectangle [0, _y.send(:mm)], CARD_SIZE[0], _line_height.send(:mm)}
    #   end
    #   _y = _y - (_padding * (i + 1)) - _line_height - 0.1
    #   _line_height = base_height - (_padding * (i + 1))
    # end
    fill_color "000000"
    # ロゴを書く
    image "./JUS.png",
      :width => 16.send(:mm),
      :height => 13.send(:mm),
      :at => [3.send(:mm), CARD_SIZE[1] - 2.send(:mm)]

    # 必要なフォントを取り込む
    font_families.update(
      "IPAex mincho" => {
        :normal => "./ipaexm.ttf"
      },
      "Mplus 2c medium" => {
        :normal => "./mplus-2c-medium.ttf"
      },
      "Mplus 2c heavy" => {
        :normal => "./mplus-2c-heavy.ttf"
      },
    )

    # 1枚目のテンプレート
    text_box "MEMBER\nNO.",
      :at => [3.send(:mm), CARD_SIZE[1] - 19.send(:mm)],
      :height => 6.send(:mm),
      :width => 8.send(:mm),
      :overflow => :shrink_to_fit,
      :leading => 2,
      :align => :right

    text_box "NAME",
      :at => [3.send(:mm), CARD_SIZE[1] - 30.send(:mm)],
      :height => 3.send(:mm),
      :width => 6.send(:mm),
      :overflow => :shrink_to_fit,
      :align => :left

    text_box "EXP. DATE",
      :at => [40.send(:mm), CARD_SIZE[1] - 19.send(:mm)],
      :height => 3.send(:mm),
      :width => 12.send(:mm),
      :overflow => :shrink_to_fit,
      :align => :left

    text_box "SIGNATURE",
      :at => [3.send(:mm), CARD_SIZE[1] - 39.send(:mm)],
      :height => 3.send(:mm),
      :width => 13.send(:mm),
      :overflow => :shrink_to_fit,
      :align => :left

    # MEMBERSHIP CARDは太字で
    font("Mplus 2c heavy") do
      text_box "MEMBERSHIP CARD",
        :at => [36.send(:mm), CARD_SIZE[1] - 10.send(:mm)],
        :height => 5.send(:mm),
        :width => 36.send(:mm),
        :overflow => :shrink_to_fit,
        :align => :left,
        :valign => :bottom
    end

    # 受け付けた引数を書き込む
    font("Mplus 2c medium") do
      text_box member_no,
        :at => [17.send(:mm), CARD_SIZE[1] - (19.5).send(:mm)],
        :width => 15.send(:mm),
        :height => 4.send(:mm),
        :overflow => :shrink_to_fit,
        :align => :left
      text_box expired_date,
        :at => [55.send(:mm), CARD_SIZE[1] - 20.send(:mm)],
        :width => 23.send(:mm),
        :height => 4.send(:mm),
        :overflow => :shrink_to_fit,
        :align => :left
      text_box name_ja,
        :at => [15.send(:mm), CARD_SIZE[1] - 25.send(:mm)],
        :width => 40.send(:mm),
        :height => 5.send(:mm),
        :overflow => :shrink_to_fit,
        :align => :left,
        :valign => :bottom
      text_box name_en,
        :at => [15.send(:mm), CARD_SIZE[1] - 30.send(:mm)],
        :width => 40.send(:mm),
        :height => 5.send(:mm),
        :overflow => :shrink_to_fit,
        :align => :left
    end

    # 二ページ目
    start_new_page

    fill_color color
    # 全体を埋める
    stroke do
      fill { rectangle [0, CARD_SIZE[1]], CARD_SIZE[0], CARD_SIZE[1]}
    end
    fill_color "000000"

    # サービスについてはcenterより
    font("Mplus 2c medium") do
      text_box "日本UNIXユーザ会の電子情報提供サービスについて",
        :at => [7.send(:mm), CARD_SIZE[1] - 2.send(:mm)],
        :width => CARD_SIZE[0] - 14.send(:mm),
        :height => 5.send(:mm),
        :overflow => :shrink_to_fit,
        :align => :center
    end

    # 文面は明朝体
    font("IPAex mincho") do
      text_box "　ニュースレターは電子メールで随時お届けします。\n" +
               "　ＷＷＷ(https://www.jus.or.jp)で、ニュースレターのバックナンバーや機関紙(/etc/wall)の取り寄せが可能です。" +
               "また、現在の会員登録内容確認や登録内容変更もＷＷＷ上の会員専用ページに用意いたしております。\n" +
               "　その他、各種お問い合わせは事務局まで電子メールでご連絡ください。",
               :at => [4.send(:mm), CARD_SIZE[1] - 8.send(:mm)],
               :width => CARD_SIZE[0] - 8.send(:mm),
               :height => 25.send(:mm),
               :overflow => :shrink_to_fit,
               :align => :left,
               :leading => 2
      # パスワード
      text_box "パスワード:    #{password}",
               :at => [25.send(:mm), CARD_SIZE[1] - 43.send(:mm)],
               :width => 45.send(:mm),
               :height => 5.send(:mm),
               :overflow => :shrink_to_fit,
               :align => :left
    end

  end
end

if __FILE__ == $0
  if ARGV.length < 7
    puts "usage: #{$0} filepath color member_no expired_date name_ja name_en password"
    exit 1
  end
  filepath = ARGV[0]
  color = ARGV[1]
  member_no = ARGV[2]
  expired_date = ARGV[3]
  name_ja = ARGV[4]
  name_en = ARGV[5]
  password = ARGV[6]
  generate_membership_card(filepath, color, member_no, expired_date, name_ja, name_en, password)
end
