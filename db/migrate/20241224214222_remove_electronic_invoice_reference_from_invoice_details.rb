class RemoveElectronicInvoiceReferenceFromInvoiceDetails < ActiveRecord::Migration[7.0]
  def change
    remove_reference :invoice_details, :electronic_invoice, foreign_key: true
  end
end

