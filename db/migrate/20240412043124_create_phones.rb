# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[7.1]
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :type
      t.references :phoneable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
