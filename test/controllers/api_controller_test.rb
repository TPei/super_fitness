require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(
      name: 'George Washington',
      name_aip: '{"allowed_purposes":[9]}',
      email: 'first@president.gov',
      password: 'history_has_its_eyes_on_you',
      password_confirmation: 'history_has_its_eyes_on_you'
    )
    @user.save
    @user.heart_rate_logs.create(heart_rate: { some: 'json' }.to_json, date: Date.today)
    @user.step_day_logs.create(step_count: 1234, date: Date.yesterday)

    @user2 = User.new(
      name: 'Thomas Jefferson',
      email: 'third@president.gov',
      password: 'real_nice_declaration',
      password_confirmation: 'real_nice_declaration'
    )
    @user2.save

    @ac = AccessCode.new(description: 'Charite Cancer Research', purpose_id: 9)
    @ac.save
  end

  test 'retrieve user accepts user_id and purpose code and returns only fields allowed for purpose' do
    skip 'until fixed'
    get "/api/users/#{@user.id}/purpose/#{@ac.code}"
    assert_response :success
    assert_equal ({ name: @user.name, email: nil, password: nil }.to_json),
      @response.body
  end

  test 'retrieve users accepts purpose code' do
    skip 'until fixed'
    get "/api/users/purpose/#{@ac.code}"
    assert_response :success
    assert_equal [@user.as_json, @user2.as_json].to_json, @response.body
  end
end
