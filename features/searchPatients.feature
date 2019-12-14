Feature: search patients as doctor

  As an doctor
  So that I can quickly search patients by user_id, first_name and last_name
  I want to see the patients matching the search query

Background: patients have been added to database

  Given the following users exist:
  | role     | first_name | last_name | email            | password | password_confirmation | is_doctor |
  | doctor   | Peter      | Pei       | pp2@gmail.com    | password | password              | true      |
  | patient  | Tom        | Brady     | tomb2@gmail.com  | password | password              | false     |
  | patient  | Steven     | Jobs      | sj@gmail.com     | password | password              | false     |
  | patient  | Tim        | Cook      | tc@gmail.com     | password | password              | false     |
  | guest    | Guest      | Guest     | guest@guest.com  | password | password              | false     |

  Then The number of patients should be 5
  Given I am logged in as "Peter"
  And I am on the searchPatients home page
  Then I should see "Search For Patient"

Scenario: search Patients by first name:

  When I fill in "search_first_name" with "Tom"
  And I press "search_submit"
  Then I should see "Tom"
  Then I should not see "Tim"

Scenario: search Patients by first name and last name:
  When I fill in "search_first_name" with "Tom"
  When I fill in "search_last_name" with "Brady"
  And I press "search_submit"
  Then I should see "Brady"
  Then I should not see "Cook"

Scenario: We can go to patients' profiles
  When I am on the searchPatients home page
  Then I should see "Tom Brady Info"

Scenario: We want to search patients by first name
  When I am on the searchPatients home page
  And I follow "first_name_sort"
  Then I should see "Steven" before "Tom"

Scenario: Only Doctor can access the searchPatient Page
  Given I log out as doctor
  Then I should see "Please log"
  When I am on the searchPatients home page
  Then I should see "Only Doctor can access this page"

  Given I am logged in as "Tom"
  When I am on the searchPatients home page
  Then I should see "Only Doctor can access this page"
