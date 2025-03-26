# lib/tasks/generar_helpers.rake
require 'yaml'

namespace :generar do
  desc "Genera helpers desde swagger.yaml para cada esquema. Ej: rake generar:helpers"
  task :helpers => :environment do
    swagger_path = Rails.root.join("swagger/v1/swagger.yaml")
    output_dir   = Rails.root.join("generator/helpers/api")

    unless File.exist?(swagger_path)
      puts "❌ No se encontró el archivo swagger.yaml en #{swagger_path}"
      exit(1)
    end

    swagger = YAML.safe_load(File.read(swagger_path), permitted_classes: [Date], aliases: true)
    schemas = swagger.dig("components", "schemas") || {}

    FileUtils.mkdir_p(output_dir)

    schemas.each do |nombre, definicion|
      nombre_snake = ActiveSupport::Inflector.underscore(nombre)
      helper_name  = "#{nombre_snake}_params_helper.rb"
      helper_path  = output_dir.join(helper_name)

      propiedades = definicion["properties"] || {}

      cuerpo = propiedades.map do |key, value|
        ejemplo = value["example"] || (value["enum"]&.first) || ejemplo_por_tipo(value["type"])
        ejemplo = ejemplo.to_s if value["type"] == "string" || value["format"] == "date"
        "#{key}: #{formato_ruby(ejemplo)}"
      end

      cuerpo_tabulado = cuerpo.map { |linea| "      #{linea}" }.join(",\n      ")

      helper = <<~RUBY
        module #{nombre}ParamsHelper
          def #{nombre_snake}_valid_params
            {
              #{cuerpo_tabulado}
            }
          end
        end
      RUBY

      File.write(helper_path, helper.strip + "\n")
      puts "✅ Generado: #{helper_path}"
    end
  end

  def ejemplo_por_tipo(tipo)
    case tipo
    when "string" then "Texto"
    when "integer" then 123
    when "number" then 12.34
    when "boolean" then true
    when "array" then []
    when "object" then {}
    else "?"
    end
  end

  def formato_ruby(valor)
    return '""' if valor.nil?
    valor.inspect
  end
end
