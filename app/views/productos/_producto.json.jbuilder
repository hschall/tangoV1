json.extract! producto, :id, :sap_id, :nombre, :um_compras, :um_inventario, :um_ventas, :costo, :precio_venta, :codigo_barras, :created_at, :updated_at
json.url producto_url(producto, format: :json)
