module QueryByExample
  extend ActiveSupport::Concern

  class_methods do
    def filter_by(params)
      query = all

      params.each do |campo, valor|
        next if valor.blank?
        column_type = columns_hash[campo]&.type

        case column_type
        when :string, :text
          query = query.where("#{campo} LIKE ?", "%#{valor}%")
        when :integer
          query = query.where("#{campo} = ?", valor.to_i) if valor.to_i.to_s == valor
        when :date
          begin
            fecha = Date.parse(valor)
            query = query.where("#{campo} = ?", fecha)
          rescue ArgumentError
            query = query.where("TO_CHAR(#{campo}, 'YYYY-MM-DD') LIKE ?", "%#{valor}%")
          end
        when :datetime
          begin
            fecha_hora = DateTime.parse(valor)
            query = query.where("#{campo} = ?", fecha_hora)
          rescue ArgumentError
            query = query.where("TO_CHAR(#{campo}, 'YYYY-MM-DD HH24:MI:SS') LIKE ?", "%#{valor}%")
          end
        end
      end

      query
    end
  end
end
