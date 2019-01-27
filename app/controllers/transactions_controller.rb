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
    @transaction = Transaction.new(transaction_params)
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  def create
    if bulk_upload?
      svc = TransactionImportService.new(params[:file].path)
      if svc.valid_file?
        svc.create_many
        format.html { render :index, notice: "Successfully created #{svc.imported_count} transactions out of #{svc.total_count}."}
      else
        format.html { render :new, error: svc.error_messages }
      end
    else
      @transaction = Transaction.new(transaction_params)

      respond_to do |format|
        if @transaction.save
          format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /transactions/1
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
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

    def bulk_upload?
      !params[:transaction][:file].empty?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:amount, :description, :date)
    end
end
