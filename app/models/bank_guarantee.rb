class BankGuarantee < ActiveRecord::Base
  include ActAsBinary
  ### Constants ###

  ### Associations ###
  belongs_to :current_transaction, foreign_key: 'transaction_id', class_name: 'Transaction'

  ### Validations ###
  validates :transaction_id, :active, presence: true

  ### Scopes ###

  ### Callbacks ###

  ### Delegation ###

  ### Plugins ###

  ### Class methods ###

  ### Instance methods ###
end
