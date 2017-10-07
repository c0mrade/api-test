require 'rails_helper'

describe BankGuarantee do
  it_behaves_like 'act_as_binary'

  describe 'attribute methods' do
    it { is_expected.to respond_to(:current_transaction) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:current_transaction) }
    it { is_expected.to validate_presence_of(:active) }
  end
end
