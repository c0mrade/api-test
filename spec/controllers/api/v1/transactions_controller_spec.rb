require 'rails_helper'

describe Api::V1::TransactionsController do
  let!(:active_transaction) { FactoryGirl.create(:transaction, :with_bank_guarantee) }

  describe 'GET /api/v1/transactions' do
    before do
      get :index, format: :json
    end

    context 'all active transactions' do
      let(:sample_response) do
        api_response['transactions'].sample.symbolize_keys.keys
      end

      it 'returns active transactions' do
        expect(sample_response).to include(:id, :name, :created_at, :status)
      end
    end
  end

  describe 'POST /api/v1/transactions' do
    context 'creates new transaction' do
      before do
        post :create, params: { transaction: { name: 'hello', active: true } }, format: :json
      end

      it_behaves_like 'render show template', [:id, :name, :created_at]

      it 'returns status created' do
        expect(response.status).to eq(201)
      end
    end

    context 'invalid transaction payload' do
      before do
        post :create, params: { transaction: { active: true } }
      end

      it_behaves_like 'save or update failure'
    end
  end

  describe 'PUT /api/v1/transactions/:id' do
    context 'updates existing active transaction' do
      before do
        put :update, params: { id: active_transaction.id, transaction: { name: 'hello22' } }, format: :json
      end

      it_behaves_like 'render show template'
      it_behaves_like 'ok response'
    end

    context 'invalid transaction payload' do
      before do
        put :update, params: { id: active_transaction.id, transaction: { name: '' } }, format: :json
      end

      it_behaves_like 'save or update failure'
    end
  end

  describe 'GET /api/v1/transactions/:id' do
    context 'returns transaction details' do
      before do
        get :show, params: { id: active_transaction.id }, format: :json
      end

      it_behaves_like 'ok response'
      it_behaves_like 'render show template'
    end
  end

  describe 'DELETE /api/v1/transactions/:id' do
    context 'returns transaction details' do
      before do
        delete :destroy, params: { id: active_transaction.id }, format: :json
      end

      it 'returns no content, destroy was successful' do
        expect(response.status).to eq(204)
      end

      context 'invalid transaction payload' do
        let(:transaction) { FactoryGirl.build_stubbed(:transaction) }
        before do
          allow(Transaction).to receive(:find).and_return(transaction)
          allow(transaction).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed)
          delete :destroy, params: { id: active_transaction.id }, format: :json
        end

        it_behaves_like 'unprocessable_entity'

        it 'renders information about the error' do
          expect(api_response['errors']).to eq("Unable to delete transaction with ID: #{transaction.id}")
        end
      end
    end
  end
end
