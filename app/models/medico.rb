class Medico < ApplicationRecord
  include QueryByExample

  belongs_to :usuario
end
