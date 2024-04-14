# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :district
      t.string :city
      t.string :uf
      t.string :zipcode
      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
