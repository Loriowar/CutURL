require 'test_helper'
require 'pry'

class BigUrlTest < ActiveSupport::TestCase
  test "Wipe db must work" do
    # DB must contain sertain refords before test wipe
    assert (BigUrl.count > 0), "DataBase is empty. Can't test work of wipe properly."

    BigUrl.wipe
    assert_equal BigUrl.count, 0, "Wipe db isn't work."
  end

  test "Delete_expired function must work" do
    # From fixture we have one expired record. Check it
    assert (BigUrl.where("d_expire < :cur_date", cur_date: DateTime.now).count > 0), "No old record(s) in db."

    BigUrl.delete_expired
    assert_equal BigUrl.where("d_expire < :cur_date", cur_date: DateTime.now).count, 0, "Unable remove old records."
  end
end