class Listing < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery
  belongs_to :area
  belongs_to :days

  with_options presence: true do
    validates :product
    validates :explanation
    validates :price
    validates :image, unless: :was_attached?
  end

  validates :price, numericality: { with: /\A[0-9]+\z/ }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 999_999_999, message: 'is out of setting range' }

  validates :category_id, :status_id, :delivery_id, :area_id, :days_id, numericality: { other_than: 1 }

  belongs_to :user
  has_one :purchase
  has_one_attached :image

  def was_attached?
    image.attached?
  end
end
