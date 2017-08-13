class Post < ActiveRecord::Base
  acts_as_taggable

  STATUS_PRIVATE = 'private'.freeze
  STATUS_PUBLIC = 'public'.freeze
  STATUS_VALUES = [STATUS_PRIVATE, STATUS_PUBLIC].map(&:freeze).freeze


  validates :title, presence: true, length: {maximum: 200}
  validates :body, :posted_at, presence: true
  validates :status, inclusion: {in: STATUS_VALUES}

  scope :common, -> {where('status = ? AND posted_at <= ?', STATUS_PUBLIC, Time.now)}
end
