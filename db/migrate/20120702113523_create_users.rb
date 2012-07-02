class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :first_name
      t.string     :last_name
      t.timestamp  :birth_date
      t.string     :email
      t.string     :university
      t.integer    :avatar_id
      t.text       :biography
      t.string     :job

      t.timestamps
    end
  end
end
