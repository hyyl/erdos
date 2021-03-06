require 'test_helper'

class MessagingAreaTests < ActionDispatch::IntegrationTest

  test "can hide messaging area" do
    visit signup_path
    click_button('Guest Login')
    fill_in "guest_username_area", :with => 'guestuser'
    click_button('Login as Guest')
    visit chatrooms_path
    fill_in "chatroom[roomname]",   :with => 'TestName'
    click_button('Create Chatroom')
    find('#messageBoxCloser').click
    assert page.has_css?("#messageContainer", visible: false)
  end

  test "hidden messaging area shows up when toggled" do
    visit signup_path
    click_button('Guest Login')
    fill_in "guest_username_area", :with => 'guestuser'
    click_button('Login as Guest')
    visit chatrooms_path
    fill_in "chatroom[roomname]",   :with => 'TestName'
    click_button('Create Chatroom')
    find('#messageBoxCloser').click
    find('#messageBoxOpener').click
    assert page.has_css?("#messageContainer", visible: true)
  end

=begin  test "rendering area can be expanded" do
    visit signup_path
    click_button('Guest Login')
    fill_in "guest_username_area", :with => 'guestuser'
    click_button('Login as Guest')
    visit chatrooms_path
    fill_in "chatroom[roomname]",   :with => 'TestName'
    click_button('Create Chatroom')
    find('#messageBoxExpander').click
    assert page.has_css?('#messageBoxMinimizer', visible: true)
  end
=end
  test "rendering area can be expanded" do
    visit signup_path
    click_button('Guest Login')
    fill_in "guest_username_area", :with => 'guestuser'
    click_button('Login as Guest')
    visit chatrooms_path
    fill_in "chatroom[roomname]",   :with => 'TestName'
    click_button('Create Chatroom')
    find('#messageBoxExpander').click
    assert page.find('#messageBoxMinimizer').visible?
  end

  test "rendering area can be re-minimized" do
    visit signup_path
    click_button('Guest Login')
    fill_in "guest_username_area", :with => 'guestuser'
    click_button('Login as Guest')
    visit chatrooms_path
    fill_in "chatroom[roomname]",   :with => 'TestName'
    click_button('Create Chatroom')
    find('#messageBoxExpander').click
    assert page.find('#messageBoxExpander').visible?
  end



  #post "/articles",
  #  params: { article: { title: "can create", body: "article successfully." } }
  #assert_response :redirect
  #follow_redirect!
  #assert_response :success
  #assert_select "p", "Title:\n  can create"
end
