require "application_system_test_case"

class DanceStylesTest < ApplicationSystemTestCase
  setup do
    @dance_style = dance_styles(:one)
  end

  test "visiting the index" do
    visit dance_styles_url
    assert_selector "h1", text: "Dance Styles"
  end

  test "creating a Dance style" do
    visit dance_styles_url
    click_on "New Dance Style"

    fill_in "Name", with: @dance_style.name
    click_on "Create Dance style"

    assert_text "Dance style was successfully created"
    click_on "Back"
  end

  test "updating a Dance style" do
    visit dance_styles_url
    click_on "Edit", match: :first

    fill_in "Name", with: @dance_style.name
    click_on "Update Dance style"

    assert_text "Dance style was successfully updated"
    click_on "Back"
  end

  test "destroying a Dance style" do
    visit dance_styles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dance style was successfully destroyed"
  end
end
