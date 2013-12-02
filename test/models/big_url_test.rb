require 'test_helper'

class BigUrlTest < ActiveSupport::TestCase

  test "invalid without real url" do
    r = BigUrl.new({vc_real_url: '', vc_short_url: ''})
    assert_false r.valid?, "Real url is not be validated"
  end

  test "final url must contain http(s)" do
    r = BigUrl.create({vc_real_url: 'oper.ru', vc_short_url: 'oper'})
    assert_match /^http:\/\//,
                 r.vc_real_url,
                 "For correct redirect real url must begin from http(s)://"
  end

  test "incorrect url format" do
    r = BigUrl.create({vc_real_url: 'wwwoperru', vc_short_url: 'wrongurl'})
    assert_false r.valid?, "Record should not be created for incorrect data"
  end

  test "record must have short name" do
    r = BigUrl.create({vc_real_url: 'http://www.oper.ru', vc_short_url: ''})
    assert r.vc_short_url.present?, "Error while generating an alias"
  end

  test "uniqueness of alias" do
    r = BigUrl.create({vc_real_url: 'http://www.google.ru', vc_short_url: 'goo'})
    assert_false r.valid?, "Record with same short name is prohibited"
  end

  test "recursion redirect" do
    r = BigUrl.new({vc_real_url: 'http://www.cuturl.com/recursion', vc_short_url: 'recursion'})
    assert_false r.valid?, "Checking of recursion isn't work"
  end

  test "spaces in url" do
    r = BigUrl.new({vc_real_url: ' http:// www.   simple.org/ ', vc_short_url: 'spacealias'})
    assert_equal 'http://www.simple.org/',
                 r.vc_real_url,
                 "Real url musn't contain space charecter"
  end


  #Expire date tests

  # Few metaprogramming magic for avoid duplication of code
  expire_dates = ["1Day", "1Week", "1Month", "1Year"]
  expire_dates.each do |date_name|
    class_eval do
      test "set #{date_name} expire data throw expire data tag" do
        r = BigUrl.create({vc_real_url: 'http://www.google.ru', vc_short_url: date_name, d_expire_tag: date_name[0..1]})
        assert_equal DateTime.now.to_date + ("#{date_name}".to_i).send("#{date_name.downcase[1..-1]}"),
                     r.d_expire.to_date,
                     "Expire date must be +#{date_name.downcase} from now"
      end
    end
  end

end
