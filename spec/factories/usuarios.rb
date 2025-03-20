FactoryBot.define do
  factory :usuario do
    nombre { 'Juan' }
    apellido_paterno { 'Pérez' }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    rol { :admin } # O puedes cambiar a :medico, :paciente según el caso
  end
end
