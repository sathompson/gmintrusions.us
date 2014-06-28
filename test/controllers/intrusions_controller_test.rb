require 'test_helper'

class IntrusionsControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_equal (Intrusion.all.sort { |a, b| a.id <=> b.id }), assigns(:intrusions), "@intrusions should be set to an array of all intrusions sorted by id."
  end
end