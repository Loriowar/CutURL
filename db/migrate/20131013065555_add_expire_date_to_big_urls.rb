class AddExpireDateToBigUrls < ActiveRecord::Migration
  def change
    add_column :big_urls, :d_expire, :date, :default => DateTime.now + 1.week
  end
end
