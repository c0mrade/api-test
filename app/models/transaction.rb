class Transaction < ActiveRecord::Base
  include ActAsBinary
  ### Constants ###

  ### Associations ###
  has_one   :bank_guarantee

  ### Validations ###
  validates :name, presence: true

  ### Scopes ###

  ### Callbacks ###
  before_destroy :destroy_bank_guarantee

  ### Delegation ###

  ### Plugins ###

  ### Class methods ###

  ### Instance methods ###
  private

  def destroy_bank_guarantee
    return unless bank_guarantee.present?
    bank_guarantee.destroy
  end
end
