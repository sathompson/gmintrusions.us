require 'test_helper'

class IntrusionsControllerTest < ActionController::TestCase
  test ':index sets @intrusions to a sorted list of all intrusions' do
    get :index
    assert_equal (Intrusion.all.sort { |a, b| a.id <=> b.id }),
      assigns(:intrusions),
      '@intrusions should be set to an array of all intrusions sorted by id.'
  end
  
  test ':create creates a new intrusion' do
    testDescription = 'eoseufnisenc'
    post :create, intrusion: { description: testDescription }
    
    assert_not_nil Intrusion.find_by(description: testDescription),
      'new intrusion not found'
  end
  
  test 'does not save without description' do
    [ nil, '' ].each do |testDescription|
      post :create, intrusion: { description: testDescription }

      assert_nil Intrusion.find_by(description: testDescription),
        'intrusion with empty description found'
    end
  end
  
  test ':new instantiates a new intrusion' do
    get :new
    assert_not_nil assigns(:intrusion), 'new intrusion not present'
  end
  
  test ':edit sets @intrusion to the correct intrusion' do
    testDescription = 'sekufbuvb'
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save
    
    get :edit, id: intrusion.id
    assert_equal intrusion, assigns(:intrusion),
      'the wrong intrusion is displayed'
  end
  
  test ':show sets @intrusion to the right intrusion' do
    testDescription = 'weubcukdbiu'
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save
    
    get :show, id: intrusion.id
    assert_equal intrusion, assigns(:intrusion),
      'the wrong intrusion is displayed'
  end
  
  test ':update updates the correct intrusion' do
    [:patch, :put].each do |http_method|
      testDescription = 'weoindsuc'
      intrusion = Intrusion.new
      intrusion.description = testDescription
      intrusion.save

      testUpdatedDescription = 'hskurncusn'
      self.send(http_method, :update, id: intrusion.id,
        intrusion: { id: intrusion, description: testUpdatedDescription })
      assert_equal intrusion, assigns(:intrusion),
        'the wrong intrusion is displayed'
      assert_equal testUpdatedDescription, assigns(:intrusion).description,
        'intrusion does not have the updated description'
    end
  end
  
  test ':destroy destroys the correct intrusion' do
    skip
    testDescription = 'jpionftygubhjkn'
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save
    
    delete :destroy, id: intrusion.id
    assert_nil Intrusion.find(intrusion.id), 'the intrusion was not deleted'
  end
end