Given(/^yapaas isn't running on (the machine|\S+)$/) do |machine|
  YAPAAS.stop(machine)
end

Given(/^yapaas is running (\S+) on (\S+)$/) do |paas, machine|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^a docker machine at (\S+)$/) do |machine|
  @machine = Docker::Machine[machine]
end

When(/^(?:She|He|I|We|They) runs? `([^`]+)`$/) do |command|
  system("command")
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^yapaas is running (\S+) on the machine$/) do |platform|
  pending # Write code here that turns the phrase above into concrete actions
end
