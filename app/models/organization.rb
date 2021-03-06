class Organization < ApplicationRecord
  include PgSearch::Model

  belongs_to :form
  has_many :devices, dependent: :nullify
  has_many :clients_organizations, dependent: :destroy
  has_many :clients, through: :clients_organizations

  validates :name, :inn, :ogrn, presence: true
  validates :inn, :ogrn, numericality: { only_integer: true }
  validates :inn, length: { is: 6 }
  validates :ogrn, length: { is: 13 }

  pg_search_scope :search_by, against: %i[name inn ogrn], using: {
      tsearch: { prefix: true }
  }

  def self.search(query)
    return [] unless query
    search_by("#{query}")
  end

  after_save :broadcast

  def broadcast
    ActionCable.server.broadcast('organizations', { organization: self })
  end
end
