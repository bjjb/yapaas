Given(/^a machine at (.+)$/) do |machine|
  YAPAAS::Machine.create(machine) unless YAPAAS.machine?(machine)
end

Given(/^yapaas isn't running on (.+)$/) do |machine|
  system <<-COMMAND
    eval $(docker-machine env #{machine}) && \
    docker stop $(docker ps -q -f "label=yapaas")
  COMMAND
end

When(/^she runs `([^`]+)`$/) do |command|
  system(command)
end

Then(/^yapaas should be running (\S+) on (\S+)$/) do |paas, machine|
  system <<-COMMAND
    eval $(docker-machine env #{machine}) && \
    docker ps -f "label=yapaas=#{paas}"
  COMMAND
end

Given(/^yapaas is running (\S+) on (\S+)$/) do |paas, machine|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^there should be an error$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the output should contain:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end
