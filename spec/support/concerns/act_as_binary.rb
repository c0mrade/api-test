require 'rails_helper'

shared_examples_for 'act_as_binary' do
  let(:model) { described_class } # the class that includes the concern

  before do
    @record = FactoryGirl.create(model.to_s.underscore.to_sym)
    @record.destroy
  end

  it 'sets active to false' do
    expect(@record.active).to be_falsy
  end

  it 'makes record not available by default. default_scope kicks in' do
    expect{ model.find(@record.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
