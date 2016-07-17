Feature: Initialize a yaPaaS cloud

  Users should be able to set up a new PaaS from scratch, using their existing
  SSH credentials. This is required to encourage adoption of yaPaaS.

  Rules:
  - User must have SSH access to the machine on which they want to deploy
    yaPaaS
  - Either the machine already has Docker installed, or it can easily be
    installed.

  
  Background:
    Given an IaaS at host.dev
    And Alice has SSH access to host.dev

  Scenario: Alice provisions a new PaaS
    Given No PaaS is running on host.dev
    When she runs yapaas create mypaas --ssh host.dev
    Then mypaas should be running on host.dev

  Scenario: Alice tries to reprovision a PaaS
    Given a PaaS called mypaas is running on host.dev
    When she runs yapaas create mypaas --ssh host.dev
    Then there should be an error
