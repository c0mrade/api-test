# ActAsBinary - Refers to act as either active or inactive (active: false)
module ActAsBinary
  extend ActiveSupport::Concern

  included do
    default_scope { unscoped.where(active: false) }
    scope :inactive, -> { unscoped.where(active: false) }
  end
end
