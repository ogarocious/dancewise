require "test_helper"

class GiraffesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @giraffe = giraffes(:one)
  end

  test "should get index" do
    get giraffes_url
    assert_response :success
  end

  test "should get new" do
    get new_giraffe_url
    assert_response :success
  end

  test "should create giraffe" do
    assert_difference('Giraffe.count') do
      post giraffes_url, params: { giraffe: {  } }
    end

    assert_redirected_to giraffe_url(Giraffe.last)
  end

  test "should show giraffe" do
    get giraffe_url(@giraffe)
    assert_response :success
  end

  test "should get edit" do
    get edit_giraffe_url(@giraffe)
    assert_response :success
  end

  test "should update giraffe" do
    patch giraffe_url(@giraffe), params: { giraffe: {  } }
    assert_redirected_to giraffe_url(@giraffe)
  end

  test "should destroy giraffe" do
    assert_difference('Giraffe.count', -1) do
      delete giraffe_url(@giraffe)
    end

    assert_redirected_to giraffes_url
  end
end
