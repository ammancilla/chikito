class Shortcut < ApplicationRecord
  validates :url, :key, presence: true
  validates :url, format: { with: URI.regexp(['http', 'https']) }
  validates :key, uniqueness: true, length: { is: 7 }
end
