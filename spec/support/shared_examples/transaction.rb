require 'rails_helper'

shared_examples_for 'save or update failure' do
  it 'returns transaction error details' do
    expect(api_response['name']).to eq(["can't be blank"])
  end

  it_behaves_like 'unprocessable_entity'
end

shared_examples_for 'unprocessable_entity' do
  it 'returns status unprocessable_entity' do
    expect(response.status).to eq(422)
  end
end

shared_examples_for 'ok response' do
  it 'returns status ok' do
    expect(response.status).to eq(200)
  end
end

shared_examples_for 'render show template' do |json_fields = [:id, :name, :created_at, :bank_guarantee_id]|
  it 'renders keys on the show jbuilder template' do
    expect(api_response.symbolize_keys.keys).to eq(json_fields)
  end
end
