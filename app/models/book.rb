class Book < ApplicationRecord
  validates :author, :title, presence: true
  validates :title, length: {minimum: 2, maximum: 150}

  belongs_to :author
end
