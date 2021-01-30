class UrlMap < ApplicationRecord
  validates :url, :token, presence: true
  validates :url, :token, uniqueness: true
  validates :url, url: { no_local: true }
  validates :token, format: { with: /\A[a-z]/ }
  validates :token, length: { minimum: 3 }
end
