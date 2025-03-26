# lib/tasks/generar_plantilla.rake
namespace :generar do
  desc "Genera una plantilla generalizada a partir de un archivo spec. Ej: rake generar:plantilla[Paciente]"
  task :plantilla, [:entidad] => :environment do |t, args|
    unless args[:entidad]
      puts "❌ Debes proporcionar el nombre singular en mayúscula de la entidad. Ej: rake generar:plantilla[Paciente]"
      exit(1)
    end

    Singular = args[:entidad]
    Plural   = ActiveSupport::Inflector.pluralize(Singular)
    singular = Singular.downcase
    plural   = Plural.downcase

    source_path = Rails.root.join("spec/requests/api/#{plural}_spec.rb")
    target_path = Rails.root.join("generator/templates/#{plural}_template.rb")

    unless File.exist?(source_path)
      puts "❌ No se encontró el archivo fuente: #{source_path}"
      exit(1)
    end

    content = File.read(source_path)

    # Reemplazos seguros: primero los plurales, luego los singulares
    content.gsub!(plural, "{{p_entidad_p}}")
    content.gsub!(singular, "{{s_entidad_s}}")
    content.gsub!(Plural, "{{P_Entidad_p}}")
    content.gsub!(Singular, "{{S_Entidad_s}}")

    FileUtils.mkdir_p(File.dirname(target_path))
    File.write(target_path, content)

    puts "✅ Plantilla generada en: #{target_path}"
  end
end
