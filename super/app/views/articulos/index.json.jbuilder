json.array!(@articulos) do |articulo|
  json.extract! articulo, :id, :descripcion, :precio, :tags
  json.url articulo_url(articulo, format: :json)
end
