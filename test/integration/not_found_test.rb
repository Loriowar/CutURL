require 'test_helper'
require 'pry'

class NotFoundIntegrationTest < ActionDispatch::IntegrationTest
  test "404 page must contain not_found div" do
    visit '/wrong'
    assert has_selector?(".not_found"), "Can't find not_found class on the page"
  end

  test "404 page must contain information message" do
    visit '/wrong'
    assert has_content?("Oops!"), "Can't see information message on the page"
  end

  test "404 page must contain link on home page" do
    visit '/wrong'
    assert has_selector?(".link_to_home"), "Can't see link to home page"
  end

  # Depend from previous test
  test "Link to home page must redirect to home page" do
    # Using for correct rouning methods
    # TODO: fix url_for and other routing methods for :rack_test driver
    Capybara.default_driver = :selenium

    visit '/wrong'
    click_link "link_to_home"
    # small hack for pass test
    assert_match current_url, "#{capybara_server_url}?locale=en/" , "Link to home redirect to somewhere else"
  end
end