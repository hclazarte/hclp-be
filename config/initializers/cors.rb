Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:1" # Cambia esto si necesitas otro dominio

    resource "*",
      headers: :any,
      expose: [ "Authorization" ], # Exponer el header de autenticación
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ]
  end
end
