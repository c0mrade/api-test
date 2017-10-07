# ActAsBinary - Refers to act as either active or inactive (active: false)
module ActAsBinary
  extend ActiveSupport::Concern

  included do
    # I ve never used default_scope with success in production. Whenever I did, I ended up having issues
    # down the road. But in this very simple example I think it works well. To only display active
    # records by default
    default_scope { where(active: true) }
    # In case there was some kind of admin dashboard where seeing these records would be relevant
    # or in case there might be some kind of restore/rollback feature request, could pull it off easily.
    scope :inactive, -> { unscoped.where(active: false) }

    # Overriding ActiveRecord method to be able to softly delete (set inactive implementing records)
    # Reason why it's wrapper in transaction is so that any code provided by the implementing
    # callback method in the base class would execute in the same transaction, and therefore either
    # all code is executed or it's rolled back. Callback block is there for destroy callback to
    # invoke since we're not really destroying the record.
    #
    # Unless setting active to true/false a better solution here would be
    # to use paranoia gem https://github.com/rubysherpas/paranoia
    # it would work the same except it would be using column called deleted_at which has certain benefits
    # over using just true false flag on active. For example if you were to query for 'destroyed' records
    # using active flag, in a given date rannge and if you had big number of records.
    # You would need to have a composite index on db with (active, updated_at) columns inside index. Vs doing the same
    # querying you would only use 1 column index on deleted_at. In the case if you are checking for active or inactive
    # records using either column is fine
    #
    # If we were to make a better solution using just active flag, and if we were to avoid using callbacks like implemnted now.
    # Where in the callbacks you would have to manually provide a code that would destroy dependent object(s).
    # We could use something like self.reflect_on_all_associations, and loop through each association and invoke destroy on it.
    # But we would have to go through couple of gotchas, like for example if we had counter_cache in the mix, we would need to
    # take care of that case and couple more.
    def destroy
      transaction do
        run_callbacks(:destroy) do
          update_attribute(:active, false) # this will modify update_at. Change to update_column if thats not necessary
          freeze # prevent any further meddline with the 'destroyed' object
        end
      end
    end
  end
end
