class Invoice < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  belongs_to :order
end
