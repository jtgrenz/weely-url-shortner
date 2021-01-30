class UrlMap < ApplicationRecord
  validates :url, :token, presence: true
  validates :url, :token, uniqueness: true
  validates :url, url: { no_local: true }
  validates :token, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :token, length: { minimum: 7 }

  before_validation :generate_token

  private

  def generate_token
    return token unless token.nil?
    salted_url = "#{SecureRandom.hex(10)}#{url}"
    self.token = Digest::SHA1.hexdigest(salted_url)[0..6]
  end
end
