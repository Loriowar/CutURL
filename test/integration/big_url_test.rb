require 'test_helper'
#require 'pry'

class BigUrlIntegrationTest < ActionDispatch::IntegrationTest

  test "Home page must contain 3 main div element" do
    #Capybara.default_driver = :rack_test
    #Capybara.default_driver = :selenium

    visit '/'
    within(".home_container") do
      # Check presence of all part of home page
      assert has_selector?(".errors_container"), "Absence of div for error"
      assert has_selector?(".main_form"), "Absence of div for main form"
      assert has_selector?(".link_notification"), "Absence of div for notification"
    end
  end

  test "Menu with additional options must slide up and down" do
    Capybara.default_driver = :selenium

    # TODO: fix root_url for selenium, by default it is "example.com"
    visit '/'
    within(".main_form") do
      assert has_no_css?("big_url_vc_short_url"), "Additional options must be hidden after load page"
      # Slide down
      click_link("addition_options_toogle")
      assert has_css?("#big_url_vc_short_url"), "Additional options must appear after click pseudo-link"
      # Slide up
      click_link("addition_options_toogle")
      assert has_no_css?("#big_url_vc_short_url"), "Additional options must be hidden agein"
    end
  end

  # Test depend from previous test with slide menu. If slide fail, then this fail too.
  test "Should create a new cutting" do
    Capybara.default_driver = :selenium

    visit '/'
    name = "shortgoo"
    within(".main_form") do
      fill_in "big_url_vc_real_url", with: "http://www.google.ru"
      click_link("addition_options_toogle")
      fill_in "big_url_vc_short_url", with: name
    end
    # Not best way to click button, if locale is changed test become failed
    click_button "Cut"
    # Must see div with success message
    #assert has_css?("#flash_link_notification"), "Can't see success message"
    assert has_content?("/#{name}"), "Can't see success message with appropriate link"
  end

  # Test depend from previous test with slide menu. If slide fail, then this fail too.
  test "Check alias button must work properly" do
    Capybara.default_driver = :selenium

    visit '/'
    within(".main_form") do
      # Open addinion options menu
      click_link("addition_options_toogle")
      # Field with alias musn't hav any colour afret load
      assert (has_no_css?("border_red") && has_no_css?("border_green")), "Alias field musn't have initial colour"
      # Fill allias field with unique string
      fill_in "big_url_vc_short_url", with: "uniq"
      click_button "check_alias_btn"
      assert has_css?(".border_green"), "Green highlight alias field doesn't work"

      # Fill allias field with exist alias
      fill_in "big_url_vc_short_url", with: "goo"
      click_button "check_alias_btn"
      assert has_css?(".border_red"), "Red highlight alias field doesn't work"
    end
  end

  #test "Duration select field must influence on expiry date" do
  #TODO: write test
  #end
end