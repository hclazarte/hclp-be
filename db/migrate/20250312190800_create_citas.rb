class CreateCitas < ActiveRecord::Migration[7.1]
  def change
    create_table :citas do |t|
      t.references :paciente, null: false, foreign_key: true
      t.references :medico, null: false, foreign_key: true
      t.date :fecha
      t.time :hora
      t.integer :estado

      t.timestamps
    end
  end
end
