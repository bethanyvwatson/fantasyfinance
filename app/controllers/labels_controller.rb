class LabelsController < ApplicationController
  before_action :authenticate_profile!
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  # GET /labels
  def index
    @labels = Label.all
  end

  # GET /labels/1
  def show
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1/edit
  def edit
  end

  # POST /labels
  def create
    @label = Label.new(label_params.merge(profile_id: current_profile.id))

    respond_to do |format|
      if @label.save
        format.html { redirect_to @label, notice: 'Label was successfully created.' }
      else
        format.html { render :new, error: @label.errors.full_messages.join(", ") }
      end
    end
  end

  # PATCH/PUT /labels/1
  # PATCH/PUT /labels/1.json
  def update
    respond_to do |format|
      if @label.update(label_params)
        format.html { redirect_to @label, notice: 'Label was successfully updated.' }
      else
        format.html { render :edit, error: @label.errors.full_messages.join(", ") }
      end
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    @label.destroy
    respond_to do |format|
      format.html { redirect_to labels_url, notice: 'Label was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def label_params
      params.require(:label).permit(:name)
    end
end
