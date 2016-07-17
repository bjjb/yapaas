Given /an IaaS at (.*)/ do |name|
  DockerMachine.ensure(name)
end

Given(/^(.+) has SSH access to (.+)$/) do |user, host|
  DockerMachine.machine(host).add_user(user)
end

Given(/^No PaaS is running on (.+)$/) do |host|
  DockerMachine.machine(host).kill(/yapaas/)
end

When(/^she runs yapaas create mypaas \-\-ssh (.+)$/) do |host|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^mypaas should be running on (.+)$/) do |host|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^a PaaS called mypaas is running on (.+)$/) do |host|
  DockerMachine.machine(host).docker('run -d -l yapaas bjjb/nginx')
end

Then(/^there should be an error$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

