
World FridayStepHelper


Given('today is Sunday') do
  @today = 'Sunday'
end

When("I ask whether it's Friday yet") do
  @actual_answer = is_it_friday(@today) # Write code here that turns the phrase above into concrete actions
end

Then('I should be told {string}') do |expected_asnwer|
  expect(@actual_answer).to eq(expected_asnwer) # Write code here that turns the phrase above into concrete actions
end

Given("today is Friday") do
  @today = 'Friday'
end