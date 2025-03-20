FactoryBot.define do
  factory :paciente do
    nombre { Faker::Name.first_name }
    apellido_paterno { Faker::Name.last_name }
    apellido_materno { Faker::Name.last_name }
    cedula { Faker::Number.number(digits: 8).to_s }
    direccion { Faker::Address.full_address }
    movil { '+591' + Faker::Number.number(digits: 8).to_s }
    email { Faker::Internet.email }
    usuario { nil } # Puede o no estar asociado a un usuario
    estado_civil { %w[soltero casado divorciado viudo].sample }
    ocupacion { Faker::Job.title }
    fecha_nacimiento { Faker::Date.birthday(min_age: 18, max_age: 80) }
    lugar_nacimiento { Faker::Address.city + ', ' + Faker::Address.country }
    telefono { '+591' + Faker::Number.number(digits: 7).to_s }
    tipo_afiliado { %w[titular beneficiario].sample }
    tipo_sangre { %w[orh_p orh_n arh_p arh_n].sample }
    estado { %w[alta baja].sample }
  end
end
