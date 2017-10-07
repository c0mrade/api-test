class Transaction < ActiveRecord::Base
  includes ActAsBinary
  validates :name, presence: true
  has_one :bank_guarantee, dependent: :destroy
end
