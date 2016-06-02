require 'test_helper'

class MmaEventsControllerTest < ActionController::TestCase
  setup do
    @mma_event = mma_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mma_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mma_event" do
    assert_difference('MmaEvent.count') do
      post :create, mma_event: { date: @mma_event.date, event_link: @mma_event.event_link, location: @mma_event.location, name: @mma_event.name, organization: @mma_event.organization }
    end

    assert_redirected_to mma_event_path(assigns(:mma_event))
  end

  test "should show mma_event" do
    get :show, id: @mma_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mma_event
    assert_response :success
  end

  test "should update mma_event" do
    patch :update, id: @mma_event, mma_event: { date: @mma_event.date, event_link: @mma_event.event_link, location: @mma_event.location, name: @mma_event.name, organization: @mma_event.organization }
    assert_redirected_to mma_event_path(assigns(:mma_event))
  end

  test "should destroy mma_event" do
    assert_difference('MmaEvent.count', -1) do
      delete :destroy, id: @mma_event
    end

    assert_redirected_to mma_events_path
  end
end
