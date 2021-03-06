class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy, :term_types]

  def show
  end

  def create
    @transaction = Transaction.new(transaction_params)
    
    respond_to do |format|
      if @transaction.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:name,:importer_id,:exporter_id, :status)
    end
end
