class TransactionsController < ApplicationController
  before_action :authenticate_profile!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  def create
    svc = TransactionsImportService.new(transaction_params[:file].path, current_profile.id)

    if svc.valid_file?
      respond_to do |format|
        svc.create_many
        format.html { redirect_to transactions_path, notice: "Successfully created #{svc.imported_count} transactions out of #{svc.total_count}."}
      end
    else
      respond_to do |format|
        format.html { redirect_to new_transaction_path, error: svc.error_messages }
      end
    end
  end

  # PATCH/PUT /transactions/1
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit, error: @transaction.errors }
      end
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:amount, :description, :date, :file, :label_id)
    end
end
