class AddOrderReferenceToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :order, foreign_key: true
  end
end
