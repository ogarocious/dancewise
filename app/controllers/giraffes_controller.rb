class GiraffesController < ApplicationController
  before_action :set_giraffe, only: %i[ show edit update destroy ]

  # GET /giraffes or /giraffes.json
  def index
    @giraffes = Giraffe.all
  end

  # GET /giraffes/1 or /giraffes/1.json
  def show
  end

  # GET /giraffes/new
  def new
    @giraffe = Giraffe.new
  end

  # GET /giraffes/1/edit
  def edit
  end

  # POST /giraffes or /giraffes.json
  def create
    @giraffe = Giraffe.new(giraffe_params)

    respond_to do |format|
      if @giraffe.save
        format.html { redirect_to @giraffe, notice: "Giraffe was successfully created." }
        format.json { render :show, status: :created, location: @giraffe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @giraffe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /giraffes/1 or /giraffes/1.json
  def update
    respond_to do |format|
      if @giraffe.update(giraffe_params)
        format.html { redirect_to @giraffe, notice: "Giraffe was successfully updated." }
        format.json { render :show, status: :ok, location: @giraffe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @giraffe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /giraffes/1 or /giraffes/1.json
  def destroy
    @giraffe.destroy
    respond_to do |format|
      format.html { redirect_to giraffes_url, notice: "Giraffe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_giraffe
      @giraffe = Giraffe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def giraffe_params
      params.fetch(:giraffe, {})
    end
end
