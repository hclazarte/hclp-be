FactoryBot.define do
  factory :medico do
    nombre { Faker::Name.first_name }
    apellido_paterno { Faker::Name.last_name }
    apellido_materno { Faker::Name.last_name }
    cedula { Faker::Number.number(digits: 8).to_s }
    direccion { Faker::Address.full_address }
    movil { '+591' + Faker::Number.number(digits: 8).to_s }
    email { Faker::Internet.email }
    registro_profesional { 'RP-' + Faker::Number.number(digits: 6).to_s }
    telefono { '+591' + Faker::Number.number(digits: 7).to_s }
    telefono2 { '+591' + Faker::Number.number(digits: 7).to_s }
    estado { [0, 1].sample } # 0 = Inactivo, 1 = Activo
    usuario_id { nil } # Puede o no estar asociado a un usuario
  end
end
