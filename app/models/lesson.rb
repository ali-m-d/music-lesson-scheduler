class Lesson < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
end
