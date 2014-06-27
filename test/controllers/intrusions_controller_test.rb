require 'test_helper'

class IntrusionsControllerTest < ActionController::TestCase
  test 'the user views an intrusion' do
    Intrusion.create description: 'test'
    get :show
  end
end