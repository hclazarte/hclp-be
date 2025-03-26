# lib/tasks/generar_spec.rake
namespace :generar do
  # Ejemplo de uso:
  # rake generar:spec["crud_template,Medico;Paciente"]
  # Separe las entidades con ;

  desc "Genera specs a partir de una plantilla para múltiples entidades. Ej: rake generar:spec[\"crud_template,Medico;Paciente\"]"
  task :spec, [:template, :rest] => :environment do |t, args|
    unless args[:template] && args[:rest]
      puts "Proporcione el nombre de la plantilla y al menos una Entidad. Ej: rake generar:spec[\"crud_template,Medico;Paciente\"]"
      exit(1)
    end

    template_name = args[:template]
    entidades     = args[:rest].to_s.split(';')

    source_path = Rails.root.join("generator/templates/#{template_name}.rb")

    unless File.exist?(source_path)
      puts "❌ No se encontró la plantilla: #{source_path}"
      exit(1)
    end

    entidades.each do |entidad|
      singular = entidad.downcase
      plural   = ActiveSupport::Inflector.pluralize(singular)
      Singular = entidad
      Plural   = ActiveSupport::Inflector.pluralize(entidad)

      target_path = Rails.root.join("generator/requests/api/#{plural}_spec.rb")
      content     = File.read(source_path)

      content.gsub!("{{S_Entidad_s}}", Singular)
      content.gsub!("{{P_Entidad_p}}", Plural)
      content.gsub!("{{s_entidad_s}}", singular)
      content.gsub!("{{p_entidad_p}}", plural)

      FileUtils.mkdir_p(File.dirname(target_path))
      File.write(target_path, content)

      puts "✅ [#{entidad}] → #{target_path}"
    end
  end
end
