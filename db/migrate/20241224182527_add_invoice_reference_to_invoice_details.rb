class AddInvoiceReferenceToInvoiceDetails < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoice_details, :invoice, foreign_key: true
  end
end
