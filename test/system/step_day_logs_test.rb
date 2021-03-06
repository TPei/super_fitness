require "application_system_test_case"

class StepDayLogsTest < ApplicationSystemTestCase
  setup do
    @step_day_log = StepDayLog.new(step_count: 123, date: Date.today)
    @step_day_log.save
  end

  test "visiting the index" do
    visit step_day_logs_url
    assert_selector "h1", text: "Step Day Logs"
  end

  test "creating a Step day log" do
    visit step_day_logs_url
    click_on "New Step Day Log"

    fill_in "Date", with: @step_day_log.date
    fill_in "Step Count", with: @step_day_log.step_count
    click_on "Create Step day log"

    assert_text "Step day log was successfully created"
    click_on "Back"
  end

  test "updating a Step day log" do
    visit step_day_logs_url
    click_on "Edit", match: :first

    fill_in "Date", with: @step_day_log.date
    fill_in "Step Count", with: @step_day_log.step_count
    click_on "Update Step day log"

    assert_text "Step day log was successfully updated"
    click_on "Back"
  end

  test "destroying a Step day log" do
    visit step_day_logs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Step day log was successfully destroyed"
  end
end
