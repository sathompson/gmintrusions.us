class CreateIntrusionsTags < ActiveRecord::Migration
  def change
    create_table :intrusions_tags, id: false do |t|
      t.integer :intrusion_id
      t.integer :tag_id
    end
  end
end
