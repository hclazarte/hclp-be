# lib/tasks/generar_plantilla.rake
namespace :generar do
  desc "Genera una plantilla reemplazando entidades"
  task :plantilla, [:singular, :plural] => :environment do |t, args|
    unless args[:singular] && args[:plural]
      puts "❌ Debes proporcionar el singular y plural. Ej: rake generar:plantilla[medico,medicos]"
      exit(1)
    end

    singular = args[:singular]
    plural = args[:plural]

    source_file = "#{plural}_spec.rb"
    source_path = Rails.root.join("spec/requests/api", source_file)
    target_path = Rails.root.join("generated/requests/api/plantilla.rb")

    unless File.exist?(source_path)
      puts "❌ No se encontró el archivo: #{source_path}"
      exit(1)
    end

    content = File.read(source_path)

    # Reemplazos simples (sin usar patrones complejos)
    content.gsub!(plural, '{{Entidades}}')
    content.gsub!(singular, '{{entidad}}')
    content.gsub!(plural.capitalize, '{{Entidades}}')
    content.gsub!(singular.capitalize, '{{Entidad}}')

    FileUtils.mkdir_p(File.dirname(target_path))
    File.write(target_path, content)

    puts "✅ Plantilla generada en: #{target_path}"
  end
end
