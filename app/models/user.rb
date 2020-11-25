class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
    validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)\w{6,12}\z/.freeze
    with_options format: { with: VALID_PASSWORD_REGEX,
                           message: 'は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります' },
                 confirmation: true,
                 length: { minimum: 6 } do
      validates :password
      validates :encrypted_password
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
