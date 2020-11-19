# フリマアプリ

# users table（ユーザー管理機能）
|      column      |      Type     |      Options    |
|------------------|---------------|-----------------|
|nickname          |string         |null: false      |
|email             |string         |null: false      |
|password          |string         |null: false      |
|name              |string         |null: false      |
|wonder            |string         |null: false      |
|birthday          |integer        |null: false

has_many :listing
has_many :purchase


# listing table（商品出品機能）

|      column      |      Type     |      Options    |
|------------------|---------------|-----------------|
|image(active_record)
|product           |text           |null: false      |
|explanation       |text           |null: false      ｜
|category_id(active_hash) 
|status(active_hash) 
|delivery(active_hash) 
|area(active_hash) 
|days(active_hash) 
|price             |integer        |null: false

belongs_to :user
has_one :purchase


# purchase table（購入記録）
|      column      |      Type     |      Options    |
|------------------|---------------|-----------------|
|user_id           |references     |foreign_key      |
|product_id        |references     |foreign_key      |

belongs_to :user
belongs_to :listing
belongs_to :street

# street address（住所）
|      column      |      Type     |      Options    |
|------------------|---------------|-----------------|
|postal_code       |string         |null: false      |
|prefectures       |string         |null: false      |
|municipality      |string         |null: false      |
|building          |string         |                 |
|phone             |string         |null: false      |

has_one :purchase