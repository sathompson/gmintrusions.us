require 'test_helper'

class IntrusionsControllerTest < ActionController::TestCase

  def self.startup
    Rake::Task['db:reset'].invoke
  end

  test ':index sets @intrusions to a sorted list of all intrusions' do
    get :index
    assert_equal (Intrusion.all.sort { |a, b| b.created_at <=> a.created_at }),
      assigns(:intrusions),
      '@intrusions should be set to an array of all intrusions sorted by id.'
  end

  test ':create creates a new intrusion' do
    testDescription = rand.to_s
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
    testDescription = rand.to_s
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save

    get :edit, id: intrusion.id
    assert_equal intrusion, assigns(:intrusion),
      'the wrong intrusion is displayed'
  end

  test ':show sets @intrusion to the right intrusion' do
    testDescription = rand.to_s
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save

    get :show, id: intrusion.id
    assert_equal intrusion, assigns(:intrusion),
      'the wrong intrusion is displayed'
  end

  test ':update updates the correct intrusion' do
    [:patch, :put].each do |http_method|
      testDescription = rand.to_s
      intrusion = Intrusion.new
      intrusion.description = testDescription
      intrusion.save

      testUpdatedDescription = rand.to_s
      self.send(http_method, :update, id: intrusion.id,
        intrusion: { id: intrusion.id, description: testUpdatedDescription })
      assert_equal intrusion, assigns(:intrusion),
        'the wrong intrusion is displayed'
      assert_equal testUpdatedDescription, assigns(:intrusion).description,
        'intrusion does not have the updated description'
    end
  end

  test ':destroy destroys the correct intrusion' do
    testDescription = rand.to_s
    intrusion = Intrusion.new
    intrusion.description = testDescription
    intrusion.save

    delete :destroy, id: intrusion.id
    assert_empty Intrusion.where(id: intrusion.id),
      'the intrusion was not deleted'
  end

  test ':update adds new tags' do
    num_tags = 3
    [:patch, :put].each do |http_method|
      intrusion = Intrusion.new
      intrusion.description = rand.to_s
      intrusion.save

      tags = []
      num_tags.times do
        tag = Tag.new
        tag.name = rand.to_s
        tag.save
        tags << tag
      end
      intrusion.tags.concat tags

      test_tag = Tag.new
      test_tag.name = rand.to_s
      test_tag.save

      form = {id: intrusion.id, description: intrusion.description,
        tag_ids: (tags << test_tag).map do |tag| tag.id end}
      self.send http_method, :update, id: intrusion.id, intrusion: form
      assert assigns(:intrusion).tags.include?(test_tag),
        "intrusion does not have new tag for http method: #{http_method}"
    end
  end

  test ':update deletes tags' do
    num_tags = 3
    [:patch, :put].each do |http_method|
      intrusion = Intrusion.new
      intrusion.description = rand.to_s
      intrusion.save

      tags = []
      num_tags.times do
        tag = Tag.new
        tag.name = rand.to_s
        tag.save
        tags << tag
      end
      intrusion.tags.concat tags

      test_tag = tags[rand num_tags]
      tags.delete test_tag

      form = {id: intrusion.id, description: intrusion.description,
        tag_ids: tags.map do |tag| tag.id end}
      self.send http_method, :update, id: intrusion.id, intrusion: form
      assert_not assigns(:intrusion).tags.include?(test_tag),
        "intrusion still has tag for http method: #{http_method}"
    end
  end

  test ':create creates new intrusion with tags' do
    num_tags = 3
    tags = []
    num_tags.times do
      tag = Tag.new
      tag.name = rand.to_s
      tag.save
      tags << tag
    end

    test_description = rand.to_s

    form = {description: test_description,
      tag_ids: tags.map do |tag| tag.id end}
    post :create, intrusion: form

    intrusion = Intrusion.find_by(description: test_description)
    tags.each do |tag|
      assert intrusion.tags.include?(tag),
        'new intrusion does not have selected tag'
    end
  end
end
