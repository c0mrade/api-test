require 'rails_helper'

describe Transaction do
  it_behaves_like 'act_as_binary'

  describe 'attribute methods' do
    it { is_expected.to respond_to(:bank_guarantee) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'callbacks' do
    context 'before_destroy' do
      it 'destroys related bank_guarantee' do
        transaction = FactoryGirl.create(:transaction, :with_bank_guarantee)
        transaction.destroy
        expect(BankGuarantee.find_by(id: transaction.bank_guarantee.id)).to be_nil
      end

      it 'destroying transaction without bank_guarantee causes no errors' do
        transaction = FactoryGirl.create(:transaction)
        expect{ transaction.destroy }.not_to raise_error
      end
    end
  end
end
