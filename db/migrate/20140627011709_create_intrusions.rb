class CreateIntrusions < ActiveRecord::Migration
  def change
    create_table :intrusions do |t|
      t.string :description

      t.timestamps
    end
  end
end
