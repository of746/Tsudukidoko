# 電子書籍ストア（共通）
Store.find_or_create_by!(store_name: "Kindle", user_id: nil)
Store.find_or_create_by!(store_name: "楽天Kobo", user_id: nil)
Store.find_or_create_by!(store_name: "ebookjapan", user_id: nil)
Store.find_or_create_by!(store_name: "honto", user_id: nil)


# ゲストログイン用アカウント
guest = User.find_or_create_by!(email: "guest@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end

# ゲスト専用ストア
guest.stores.find_or_create_by!(store_name: "ABCD書店")

# ゲスト用シリーズ
guest.seriesbooks.find_or_create_by!(title: "葬送のフリーレン", author: "山田鐘人／アベツカサ", cover_url: "http://books.google.com/books/content?id=3B33DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
guest.seriesbooks.find_or_create_by!(title: "ドラゴンボール", author: "鳥山明", cover_url: "http://books.google.com/books/content?id=qdVuCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
guest.seriesbooks.find_or_create_by!(title: "鬼滅の刃", author: "吾峠呼世晴", cover_url: "http://books.google.com/books/content?id=Mj1cDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
guest.seriesbooks.find_or_create_by!(title: "ドラえもん", author: "藤子・F・不二雄", cover_url: "http://books.google.com/books/content?id=_GLeDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
guest.seriesbooks.find_or_create_by!(title: "ジョジョの奇妙な冒険", author: "荒木飛呂彦", cover_url: "http://books.google.com/books/content?id=7DJyCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")

# ストアに紐づけて本を作成
frieren = guest.seriesbooks.find_or_create_by!(title: "葬送のフリーレン", author: "山田鐘人／アベツカサ")
frieren.books.find_or_create_by!(volume_number: 1, store_id: 1)
frieren.books.find_or_create_by!(volume_number: 2, store_id: 1)
frieren.books.find_or_create_by!(volume_number: 3, store_id: 1)
frieren.books.find_or_create_by!(volume_number: 4, store_id: 1)
frieren.books.find_or_create_by!(volume_number: 5, store_id: 2)
frieren.books.find_or_create_by!(volume_number: 6, store_id: 2)
frieren.books.find_or_create_by!(volume_number: 7, store_id: 2)
frieren.books.find_or_create_by!(volume_number: 8, store_id: 3)
frieren.books.find_or_create_by!(volume_number: 9, store_id: 3)
frieren.books.find_or_create_by!(volume_number: 10, store_id: 3)
frieren.books.find_or_create_by!(volume_number: 11, store_id: 4)
frieren.books.find_or_create_by!(volume_number: 12, store_id: 4)
frieren.books.find_or_create_by!(volume_number: 13, store_id: 4)
frieren.books.find_or_create_by!(volume_number: 14, store_id: 4)

dragonball = guest.seriesbooks.find_or_create_by!(title: "ドラゴンボール", author: "鳥山明")
dragonball.books.find_or_create_by!(volume_number: 1, store_id: 1)
dragonball.books.find_or_create_by!(volume_number: 2, store_id: 2)
dragonball.books.find_or_create_by!(volume_number: 3, store_id: 3)
dragonball.books.find_or_create_by!(volume_number: 4, store_id: 4)

kimetsu = guest.seriesbooks.find_or_create_by!(title: "鬼滅の刃", author: "吾峠呼世晴")
kimetsu.books.find_or_create_by!(volume_number: 1, store_id: 1)
kimetsu.books.find_or_create_by!(volume_number: 2, store_id: 2)
kimetsu.books.find_or_create_by!(volume_number: 3, store_id: 3)
kimetsu.books.find_or_create_by!(volume_number: 4, store_id: 4)

doraemon = guest.seriesbooks.find_or_create_by!(title: "ドラえもん", author: "藤子・F・不二雄")
doraemon.books.find_or_create_by!(volume_number: 1, store_id: 1)
doraemon.books.find_or_create_by!(volume_number: 2, store_id: 2)
doraemon.books.find_or_create_by!(volume_number: 3, store_id: 3)
doraemon.books.find_or_create_by!(volume_number: 4, store_id: 4)

jojo = guest.seriesbooks.find_or_create_by!(title: "ジョジョの奇妙な冒険", author: "荒木飛呂彦")
jojo.books.find_or_create_by!(volume_number: 1, store_id: 1)
jojo.books.find_or_create_by!(volume_number: 2, store_id: 2)
jojo.books.find_or_create_by!(volume_number: 3, store_id: 3)
jojo.books.find_or_create_by!(volume_number: 4, store_id: 4)