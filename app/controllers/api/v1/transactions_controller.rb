class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy, :term_types]

  def show
    render :show
  end

  def index
    @transactions = Transaction.all
    render :index
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render :show, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      render :show, status: :ok
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy!
    head :no_content

    rescue ActiveRecord::RecordNotDestroyed => err
      render json: { errors: "Unable to delete transaction with ID: #{@transaction.id}" }, status: :unprocessable_entity
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:name, :active, :importer_id, :exporter_id, :status)
    end
end
