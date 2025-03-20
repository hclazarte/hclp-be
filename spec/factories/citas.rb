FactoryBot.define do
  factory :cita do
    fecha { Faker::Date.forward(days: 10) }
    hora { Faker::Time.forward(days: 10, period: :morning).strftime('%H:%M') }
    estado { [0, 1, 2, 3].sample }
    medico { association :medico }
    paciente { association :paciente }
  end
end
