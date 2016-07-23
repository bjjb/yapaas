Feature: You can create a new cloud from scratch

  Users should be able to set up a new PaaS from scratch on the machines to
  which they already have access.

  Rules:
  - User must have SSH access to the machine on which they want to deploy
    yaPaaS
  - Either the machine already has Docker installed, or it can easily be
    installed
  
  Background:
    Given a machine at yapaas.test1
    And a user Alice
    And she has ssh access to yapaas.test1

  Scenario: Alice provisions a new PaaS
    Given yapaas isn't running on default
    When she runs `yapaas create -m default my.paas`
    Then yapaas should be running my.paas on default

  Scenario: Alice tries to reprovision a PaaS
    Given yapaas is running my.paas on default
    When she runs `yapaas create -m default my.paas`
    Then there should be an error

  Scenario: Alice provisions a new PaaS
    Given yapaas is running my.paas on default
    When she runs `yapaas create -m default my.other.paas`
    Then yapaas should be running my.other.paas on default
