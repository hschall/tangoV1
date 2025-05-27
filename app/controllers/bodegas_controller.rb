class BodegasController < ApplicationController
  before_action :set_bodega, only: %i[ show edit update destroy ]

  # GET /bodegas or /bodegas.json
  def index
    @bodegas = Bodega.all
  end

  # GET /bodegas/1 or /bodegas/1.json
  def show
  end

  # GET /bodegas/new
  def new
    @bodega = Bodega.new
  end

  # GET /bodegas/1/edit
  def edit
  end

  # POST /bodegas or /bodegas.json
  def create
    @bodega = Bodega.new(bodega_params)

    respond_to do |format|
      if @bodega.save
        format.html { redirect_to bodegas_path, notice: "CEDIS creado exitosamente." }
        format.json { render :show, status: :created, location: @bodega }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bodega.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bodegas/1 or /bodegas/1.json
  def update
    respond_to do |format|
      if @bodega.update(bodega_params)
        format.html { redirect_to bodegas_path, notice: "CEDIS actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @bodega }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bodega.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bodegas/1 or /bodegas/1.json
  def destroy
    @bodega.destroy!

    respond_to do |format|
      format.html { redirect_to bodegas_path, status: :see_other, notice: "Se ha elminado el CEDIS." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bodega
      @bodega = Bodega.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bodega_params
      params.require(:bodega).permit(:codigo, :nombre, :direccion, :cp, :activo)
    end
end
