json.array!(@correos) do |correo|
  json.extract! correo, :id, :remitente, :mensaje, :departamento
  json.url correo_url(correo, format: :json)
end
