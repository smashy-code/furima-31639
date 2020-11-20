# フリマアプリ

# users table（ユーザー管理機能）
|      column      |      Type     |      Options    |
|------------------|---------------|-----------------|
|nickname          |string         |null: false      |
|email             |string         |null: false      |
|encrypted_password|string         |null: false      |
|last_name         |string         |null: false      |
|first_name        |string         |null: false      |
|last_name_kana    |string         |null: false      |
|first_name_kana   |string         |null: false      |
|birthday          |data           |null: false

has_many :listings
has_many :purchases


# listing table（商品出品機能）

|      column             |   Type      |     Options    |
|-------------------------|------------|-----------------|
|product                  |string      |null: false      |
|explanation              |text        |null: false      ｜
|category_id(active_hash) ｜integer    |null:false       |
|status_id(active_hash)   ｜integer    |null:false        |
|delivery_id(active_hash) ｜integer    |null:false        |
|area_id(active_hash)     ｜integer    |null:false        |
|days_id(active_hash)     ｜integer    |null:false        |
|price                     |integer    |null:false        |
|user_id                  |references  |foreign_key: true|

belongs_to :user
has_one :purchase


# purchase table（購入記録）
|      column      |      Type     |      Options    |
|------------------|---------------|-----------------|
|user               |references    |foreign_key: true|
|product           |references     |foreign_key: true|

belongs_to :user
belongs_to :listing
has_one    :street

# street address（住所）
|      column      |      Type        |      Options    |
|------------------|------------------|-----------------|
|postal_code       |integer            |null: false|
|prefecture_id(active_hash) |integer   |null: false     |
|municipality      |string            |null:false       |
|building          |string            |null:false       |
|phone              |string            |null:false       |
belongs_to :purchase