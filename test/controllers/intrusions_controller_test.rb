require 'test_helper'

class IntrusionsControllerTest < ActionController::TestCase
  test ':index sets @intrusions to a sorted list of all intrusions' do
    get :index
    assert_equal (Intrusion.all.sort { |a, b| a.id <=> b.id }), assigns(:intrusions), "@intrusions should be set to an array of all intrusions sorted by id."
  end
  
  test ':create creates a new intrusion' do
    testDesripton = "eoseufnisenc"
    post :create, intrusion: { description: testDescription }
    
    intrusion = Intrusion.find_by(description: testDescription)
    assert_not_nil intrusion, "no intrusion found with the test description"
  end
  
  test 'does not create a new intrusion with nil description' do
    intrusion = Intrusion.new
    assert_not intrusion.save, "the intrusion was saved"
  end
  
  #Figure out what to add here
  test ':new things' do
    #Implement this
    assert true
  end
  
  test ':edit sets @intrusion to the correct intrusion' do
    testDescription = "sekufbuvb"
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save
    
    get :edit, id: intrusion.id
    assert_equal intrusion, assigns(:intrusion), "the wrong intrusion is displayed"
  end
  
  test ':show sets @intrusion to the right intrusion' do
    testDescription = "weubcukdbiu"
    intrusion = Intrusion.new
    intrusion.descripton = testDescription
    intrusion.save
    
    get :show, id: intrusion.id
    assert_equal intrusion, assigns(:intrusion), "the wrong intrusion is displayed"
  end
  
  test 'patch :update updates the correct intrusion' do
    testDescription = "weoindsuc"
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save
    
    testUpdatedDescription = "hskurncusn"
    patch :update, intrusion: { id: intrusion, description: testUpdatedDescription }
    assert_equal intrusion, assigns(:intrusion), "the wrong intrusion is displayed"
    assert_equal testUpdatedDescription, assigns(:intrusion).description, "intrusion does not have the updated description"
  end
  
  test 'put :update updates the correct intrusion' do
    testDescription = "ybcnoiweo"
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save
    
    testUpdatedDescription = "hskurncusn"
    put :update, intrusion: { id: intrusion, description: testUpdatedDescription }
    assert_equal intrusion, assigns(:intrusion), "the wrong intrusion is displayed"
    assert_equal testUpdatedDescription, assigns(:intrusion).description, "intrusion does not have the updated description"
  end
  
  test ':destroy destroys the correct intrusion' do
    testDescription = "jpionftygubhjkn"
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save
    
    delete :destroy, id: intrusion.id
    assert_nil Intrusion.find(intrusion.id), "the intrusion was not deleted"
  end
end