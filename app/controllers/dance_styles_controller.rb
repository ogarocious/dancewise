class DanceStylesController < ApplicationController
  before_action :set_dance_style, only: %i[ show edit update destroy ]

  # GET /dance_styles or /dance_styles.json
  def index
    @dance_styles = DanceStyle.all
  end

  # GET /dance_styles/1 or /dance_styles/1.json
  def show
  end

  # GET /dance_styles/new
  def new
    @dance_style = DanceStyle.new
  end

  # GET /dance_styles/1/edit
  def edit
  end

  # POST /dance_styles or /dance_styles.json
  def create
    @dance_style = DanceStyle.new(dance_style_params)

    respond_to do |format|
      if @dance_style.save
        format.html { redirect_to @dance_style, notice: "Dance style was successfully created." }
        format.json { render :show, status: :created, location: @dance_style }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dance_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dance_styles/1 or /dance_styles/1.json
  def update
    respond_to do |format|
      if @dance_style.update(dance_style_params)
        format.html { redirect_to @dance_style, notice: "Dance style was successfully updated." }
        format.json { render :show, status: :ok, location: @dance_style }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dance_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dance_styles/1 or /dance_styles/1.json
  def destroy
    @dance_style.destroy
    respond_to do |format|
      format.html { redirect_to dance_styles_url, notice: "Dance style was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dance_style
      @dance_style = DanceStyle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dance_style_params
      params.require(:dance_style).permit(:name)
    end
end
