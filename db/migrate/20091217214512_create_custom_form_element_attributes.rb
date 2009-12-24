class CreateCustomFormElementAttributes < ActiveRecord::Migration
  def self.up
    create_table :custom_form_element_attributes do |t|

      t.column :custom_form_element_id, :integer
      t.column :key, :string, :limit => 255
      t.column :value, :text

      t.column :created_at, :datetime
    end

    add_index(:custom_form_element_attributes, :custom_form_element_id)
  end

  def self.down
    drop_table :custom_form_element_attributes
  end
end
