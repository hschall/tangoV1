class SucursalesController < ApplicationController
  before_action :set_sucursal, only: %i[ show edit update destroy ]

  # GET /sucursales or /sucursales.json
  def index
    @sucursales = Sucursal.all
  end

  # GET /sucursales/1 or /sucursales/1.json
  def show
  end

  # GET /sucursales/new
  def new
    @sucursal = Sucursal.new
  end

  # GET /sucursales/1/edit
  def edit
  end

  # POST /sucursales or /sucursales.json
  def create
    @sucursal = Sucursal.new(sucursal_params)

    respond_to do |format|
      if @sucursal.save
        format.html { redirect_to sucursales_path, notice: "Sucursal creada exitosamente." }
        format.json { render :show, status: :created, location: @sucursal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sucursales/1 or /sucursales/1.json
  def update
    respond_to do |format|
      if @sucursal.update(sucursal_params)
        format.html { redirect_to sucursales_path, notice: "Sucursal se ha actualizado existosamente." }
        format.json { render :show, status: :ok, location: @sucursal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sucursal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sucursales/1 or /sucursales/1.json
  def destroy
    @sucursal.destroy!

    respond_to do |format|
      format.html { redirect_to sucursales_path, status: :see_other, notice: "Se ha eliminado la Sucursal." }
      format.json { head :no_content }
    end
  end

  def import_create
  if params[:file].blank?
    redirect_to import_sucursales_path, alert: "Por favor selecciona un archivo válido."
    return
  end

  begin
    spreadsheet = Roo::Spreadsheet.open(params[:file].path)
    header = spreadsheet.row(1).map(&:to_s)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      sucursal_data = row.slice("codigo", "ruta", "direccion", "cp", "activo", "bodega_id")

      # Normalize `activo`
      activo_input = sucursal_data["activo"].to_s.downcase.strip
      sucursal_data["activo"] = %w[true 1 sí si yes].include?(activo_input)

      sucursal = Sucursal.find_or_initialize_by(codigo: sucursal_data["codigo"])
      sucursal.assign_attributes(sucursal_data)
      sucursal.save!
    end

    redirect_to sucursales_path, notice: "Sucursales importadas correctamente."
  rescue => e
    redirect_to import_sucursales_path, alert: "Error al importar: #{e.message}"
  end
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sucursal
      @sucursal = Sucursal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sucursal_params
      params.require(:sucursal).permit(:codigo, :ruta, :direccion, :cp, :activo, :bodega_id)
    end
end
