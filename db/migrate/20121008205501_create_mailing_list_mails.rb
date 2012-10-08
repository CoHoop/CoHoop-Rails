class CreateMailingListMails < ActiveRecord::Migration
  def change
    create_table :mailing_list_mails do |t|
      t.string :mail
      t.string :university

      t.timestamps
    end
  end
end
