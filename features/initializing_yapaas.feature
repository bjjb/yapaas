Feature: You can create a new cloud from scratch

  Users should be able to set up a new PaaS from scratch on the machines to
  which they already have access.

  Rules:
  - User must have SSH access to the machine on which they want to deploy
    yaPaaS
  - Either the machine already has Docker installed, or it can easily be
    installed
  
  Background:
    Given a docker machine at yapaas.test

  Scenario: I list the available machines
    When I run `yapaas machines`
    Then I should see "yapaas.test"

  Scenario: I check which machines have yapaas on them
    Given yapaas isn't running on the machine
    When I run `yapaas machine status yapaas.test`
    Then I should see "Status: Ready"
    When I run `yapaas platform create -m yapaas.test my.paas`
    And I run `yapaas machine status yapaas.test`
    Then I should see "Status: Running"

  Scenario: I provision a new PaaS
    Given yapaas isn't running on the machine
    When I run `yapaas platform create -m yapaas.test my.paas`
    Then I should see "platform 'my.paas' created on 'yapaas.test'"

  Scenario: I try to reprovision a PaaS
    Given yapaas is running my.paas on the machine
    When I run `yapaas platform create -m yapaas.test my.paas`
    Then I should see "platform 'my.paas' is already running on 'yapaas.test'"

  Scenario: I provision a new PaaS
    Given yapaas is running my.paas on the machine
    When I run `yapaas platform create -m yapaas.test another.paas`
    Then I should see "platform 'another.paas' created on 'yapaas.test'"
