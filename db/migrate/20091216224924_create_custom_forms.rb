class CreateCustomForms < ActiveRecord::Migration
  def self.up
    create_content_table :custom_forms do |t|
      t.string :name, :limit => 255
      t.string :email, :limit => 255
      t.string :success_url, :limit => 255
    end
    
    ContentType.create!(:name => "CustomForm", :group_name => "CustomForm")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'CustomForm'])
    CategoryType.all(:conditions => ['name = ?', 'Custom Form']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :custom_form_versions
    drop_table :custom_forms
  end
end
