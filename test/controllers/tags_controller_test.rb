require 'test_helper'

def self.startup
  Rake::Task['db:reset'].invoke
end

class TagsControllerTest < ActionController::TestCase
  test ':index sets @tags to a sorted list of all tags' do
    get :index
    assert_equal (Tag.all.sort { |a, b| a.name <=> b.name }),
      assigns(:tags),
      '@tags should be set to an array of all tags sorted by name.'
  end
  
  test ':create creates a new tag' do
    testName = Faker::Lorem.word
    post :create, tag: { name: testName }
    
    assert_not_nil Tag.find_by(name: testName),
      'new tag not found'
  end
  
  test 'does not save without name' do
    [ nil, '' ].each do |testName|
      post :create, tag: { name: testName }

      assert_nil Tag.find_by(name: testName),
        'tag with empty description found'
    end
  end
  
  test ':new instantiates a new tag' do
    get :new
    assert_not_nil assigns(:tag), 'new tag not present'
  end
  
  test ':edit sets @tag to the correct tag' do
    testName = Faker::Lorem.word
    tag = Tag.new
    tag.name = testName
    tag.save
    
    get :edit, id: tag.id
    assert_equal tag, assigns(:tag),
      'the wrong tag is displayed'
  end
  
  test ':show sets @tag to the right tag' do
    testName = Faker::Lorem.word
    tag = Tag.new
    tag.name = testName
    tag.save
    
    get :show, id: tag.id
    assert_equal tag, assigns(:tag),
      'the wrong tag is displayed'
  end
  
  test ':update updates the correct tag' do
    [:patch, :put].each do |http_method|
      testName = Faker::Lorem.word
      tag = Tag.new
      tag.name = testName
      tag.save

      testUpdatedName = Faker::Lorem.word
      self.send(http_method, :update, id: tag.id,
        tag: { id: tag.id, name: testUpdatedName })
      assert_equal tag, assigns(:tag),
        'the wrong tag is displayed'
      assert_equal testUpdatedName, assigns(:tag).name,
        'tag does not have the updated name'
    end
  end
  
  test ':destroy destroys the correct tag' do
    testName = Faker::Lorem.word
    tag = Tag.new
    tag.name = testName
    tag.save
    
    delete :destroy, id: tag.id
    assert_empty Tag.where(id: tag.id),
      'the tag was not deleted'
  end
end
