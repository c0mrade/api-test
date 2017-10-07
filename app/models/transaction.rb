class Transaction < ActiveRecord::Base
  include ActAsBinary
  ### Constants ###

  ### Associations ###
  has_one   :bank_guarantee

  ### Validations ###
  validates :name, presence: true

  ### Scopes ###

  ### Callbacks ###
  before_destroy { |transaction| bank_guarantee.destroy }

  ### Delegation ###

  ### Plugins ###

  ### Class methods ###

  ### Instance methods ###
end
