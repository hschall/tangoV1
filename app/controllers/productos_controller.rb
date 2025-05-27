class ProductosController < ApplicationController
  before_action :set_producto, only: %i[ show edit update destroy ]

  # GET /productos or /productos.json
  def index
    @productos = Producto.all
  end

  # GET /productos/1 or /productos/1.json
  def show
  end

  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # GET /productos/1/edit
  def edit
  end

  # POST /productos or /productos.json
  def create
    @producto = Producto.new(producto_params)

    respond_to do |format|
      if @producto.save
        format.html { redirect_to productos_path, notice: "Producto creado exitosamente." }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1 or /productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to productos_path, notice: "Producto se ha actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @producto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1 or /productos/1.json
  def destroy
    @producto.destroy!

    respond_to do |format|
      format.html { redirect_to productos_path, status: :see_other, notice: "Se ha elminado el producto" }
      format.json { head :no_content }
    end
  end

  def import_create
  if params[:file].blank?
    redirect_to import_productos_path, alert: "Por favor selecciona un archivo válido."
    return
  end

  begin
    spreadsheet = Roo::Spreadsheet.open(params[:file].path)
    header = spreadsheet.row(1).map(&:to_s)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      producto_data = row.slice("sap_id", "nombre", "um_compras", "um_inventario", "um_ventas", "costo", "precio_venta", "codigo_barras")

      producto = Producto.find_or_initialize_by(sap_id: producto_data["sap_id"])
      producto.assign_attributes(producto_data)
      producto.save!
    end

    redirect_to productos_path, notice: "Productos importados correctamente."
  rescue => e
    redirect_to import_productos_path, alert: "Error al importar: #{e.message}"
  end
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def producto_params
      params.require(:producto).permit(:sap_id, :nombre, :um_compras, :um_inventario, :um_ventas, :costo, :precio_venta, :codigo_barras)
    end
end
