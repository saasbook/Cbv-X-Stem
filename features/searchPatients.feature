Feature: search patients as doctor

  As an doctor
  So that I can quickly search patients by user_id, first_name and last_name
  I want to see the patients matching the search query

Background: patients have been added to database

  Given the following patients exist:
  | first_name | last_name | email           | password | password_confirmation |
  | Peter      | Pei       | pp2@gmail.com   | password | password              |
  | Tom        | Brady     | tomb2@gmail.com | password | password              |
  | Steven     | Jobs      | sj@gmail.com    | password | password              |
  | Tim        | Cook      | tc@gmail.com    | password | password              |

  Then The number of patients should be 4
  And I am on the searchPatients home page

#TO DO define paths and find the patients
Scenario: search Patients by first name:
  When I fill in "search_first_name" with "Peter"
  And I press "search_submit"
  Then I should see "Peter"
  Then I should not see "Brady"

Scenario: search Patients by first name and last name:
  When I fill in "search_first_name" with "Tom"
  When I fill in "search_last_name" with "Brady"
  And I press "search_submit"
  Then I should see "Brady"
  Then I should not see "Pei"

Scenario: We can go to patients' profiles
  When I am on the searchPatients home page
  Then I should see "Goes to Peter Pei profile"
  And I follow "1_profile"
  Then I should see "Peter Pei"
  And I should see "Edit Profile"

Scenario: We want to search parients by first name
  When I am on the searchPatients home page
  And I follow "first_name_sort"
  Then I should see "Steven" before "Tom"

