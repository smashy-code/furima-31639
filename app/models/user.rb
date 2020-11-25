class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname

    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,12}+\z/i.freeze
    with_options format: { with: VALID_PASSWORD_REGEX,
                           message: 'は半角6~12文字英小文字・数字それぞれ１文字以上含む必要があります' },
                 confirmation: true,
                 length: { minimum: 6 } do
      validates :password
    end

    with_options format: { with: /\A[ぁ-んァ-ンー-龥]/ } do
      validates :last_name
      validates :first_name_kana
    end

    with_options format: {
      with: /\A[ァ-ヶー－]+\z/,
      message: '全角カタカナのみで入力して下さい'
    } do
      validates :last_name_kana
      validates :first_name_kana
    end

    validates :birthday
  end

  has_many :listings
  has_many :purchases
end
