class CreateBigUrls < ActiveRecord::Migration
  def change
    create_table :big_urls, {:primary_key => :n_big_url_id } do |t|
      t.string :vc_real_url,
               limit: 2000
      t.string :vc_short_url,
               limit: 16
      t.string :vc_rem,
               limit: 500
      t.date   :d_create

      t.timestamps
    end
  end
end
