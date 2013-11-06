require 'test_helper'

class BigUrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "invalid without real url" do
    r = BigUrl.new({vc_real_url: '', vc_short_url: ''})
    assert !r.valid?, "Real url is not be validated"
  end

  test "final url must contain http(s)" do
    r = BigUrl.create({vc_real_url: 'oper.ru', vc_short_url: 'oper'})
    assert_match /^http:\/\//,  r.vc_real_url, "For correct redirect real url must begin from http(s)://"
  end

  test "incorrect url format" do
    r = BigUrl.create({vc_real_url: 'wwwoperru', vc_short_url: 'wrongurl'})
    assert !r.valid?, "Record should not be created for incorrect data"
  end

  test "record must have short name" do
    r = BigUrl.create({vc_real_url: 'http://www.oper.ru', vc_short_url: ''})
    assert r.vc_short_url.present?, "Error while generating an alias"
  end

  test "uniqueness of alias" do
    r = BigUrl.create({vc_real_url: 'http://www.google.ru', vc_short_url: 'goo'})
    assert !r.valid?, "Record with same short name is prohibited"
  end

  test "recursion redirect" do
    r = BigUrl.new({vc_real_url: 'http://www.cuturl.com/recursion', vc_short_url: 'recursion'})
    assert !r.valid?, "Checking of recursion isn't work"
  end

  test "spaces in url" do
    r = BigUrl.new({vc_real_url: ' http:// www.   simple.org/ ', vc_short_url: 'spacealias'})
    assert_equal 'http://www.simple.org/', r.vc_real_url, "Real url musn't contain space charecter"
  end

end
