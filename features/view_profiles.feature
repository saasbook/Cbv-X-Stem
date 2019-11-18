Feature: Managing profiles

  As a doctor
  So that I can view and edit my patients' information
  I want to be able to view and edit patient profiles

  As a doctor
  So that I can protect my patients' privacy
  I want to make sure patients cannot view or modify any profile but their own

Background: Add doctors and patients to the database

  Given the following users exist
  | first_name | last_name | email           | password | password_confirmation | is_doctor |
  | Peter      | Pei       | pp2@gmail.com   | password | password              | true      |
  | Tom        | Brady     | tomb2@gmail.com | password | password              | false     |
  | Steven     | Jobs      | sj@gmail.com    | password | password              | false     |
  | Tim        | Cook      | tc@gmail.com    | password | password              | false     |

Scenario: Logging in
  When I am logged in as "Peter"
  Then I should be on the site home page
  And I should see "Signed in successfully."

Scenario: Doctor should be able to view patient profiles
  Given I am logged in as "Peter"
  When I go to the profile of "Tom"
  Then I should be on the profile of "Tom"

Scenario: Doctor should be able to go to the edit page of patient profiles
  Given I am logged in as "Peter"
  And I go to the profile of "Tom"
  And I press "Edit Profile"
  Then I should be on the editing page of "Tom"

Scenario: Doctor should be able to modify patient profiles
  Given I am logged in as "Peter"
  And I am on the editing page of "Tom"
  And I fill in all fields with "Placeholder values"
  And I fill in "Health Plan:" with "A new health plan for Tom Brady"
  And I press "Submit change"
  Then I should be on the profile of "Tom"
  And I should see "Tom Brady's profile has been successfully updated."
  And I should see "A new health plan for Tom Brady"
