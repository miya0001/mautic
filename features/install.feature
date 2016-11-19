Feature: Install Mautic

  @install
  Scenario: Install Mautic
    Given the screen size is 1440x900

    When I am on "/"
    Then I am on "/installer"
    And I should see "Mautic Installation - Environment Check"

    When I press "Next Step"
    Then I am on "/installer/step/1"
    And I should see "Mautic Installation - Database Setup"

    When I fill in the following:
      |install_doctrine_step[backup_tables] |0           |
    Then I should not see "Prefix for backup tables"

    When I fill in the following:
      |install_doctrine_step[backup_tables] |1           |
    Then I should see "Prefix for backup tables"

    When I fill in the following:
      |install_doctrine_step[driver]        |pdo_mysql   |
      |install_doctrine_step[host]          |localhost   |
      |install_doctrine_step[port]          |3306        |
      |install_doctrine_step[name]          |mautic-tests|
      |install_doctrine_step[user]          |root        |
      |install_doctrine_step[password]      |            |
      |install_doctrine_step[backup_tables] |1           |
      |install_doctrine_step[backup_prefix] |bak_        |
    And I wait for 3 seconds
    And I press "Next Step"
    Then I should see "Mautic Installation - Administrative User"
