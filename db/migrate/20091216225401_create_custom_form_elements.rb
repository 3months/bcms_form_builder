class CreateCustomFormElements < ActiveRecord::Migration
  def self.up
    create_table :custom_form_elements do |t|

      t.column :custom_form_id, :integer
      t.column :type, :string, :limit => 32
      t.column :name, :string, :limit => 255
      t.column :position, :integer

      t.timestamps
    end

    add_index(:custom_form_elements, :custom_form_id)
  end

  def self.down
    drop_table :custom_form_elements
  end
end
