require "application_system_test_case"

class GiraffesTest < ApplicationSystemTestCase
  setup do
    @giraffe = giraffes(:one)
  end

  test "visiting the index" do
    visit giraffes_url
    assert_selector "h1", text: "Giraffes"
  end

  test "creating a Giraffe" do
    visit giraffes_url
    click_on "New Giraffe"

    click_on "Create Giraffe"

    assert_text "Giraffe was successfully created"
    click_on "Back"
  end

  test "updating a Giraffe" do
    visit giraffes_url
    click_on "Edit", match: :first

    click_on "Update Giraffe"

    assert_text "Giraffe was successfully updated"
    click_on "Back"
  end

  test "destroying a Giraffe" do
    visit giraffes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Giraffe was successfully destroyed"
  end
end
