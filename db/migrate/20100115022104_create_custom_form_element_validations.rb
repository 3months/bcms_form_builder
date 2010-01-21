class CreateCustomFormElementValidations < ActiveRecord::Migration
  def self.up
    create_table :custom_form_element_validations do |t|

      t.column :custom_form_element_id, :integer
      t.column :key, :string, :limit => 64
      
      t.timestamps
    end
  end

  def self.down
    drop_table :custom_form_element_validations
  end
end
