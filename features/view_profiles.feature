Feature: Managing profiles

  As a doctor
  So that I can view and edit my patients' information
  I want to be able to view and edit patient profiles

  As a doctor
  So that I can protect my patients' privacy
  I want to make sure patients cannot view or modify any profile but their own

Background: Add doctors and patients to the database
    Given the following users exist:
    | role     | first_name | last_name | email            | password | password_confirmation | is_doctor |
    | doctor   | Peter      | Pei       | pp2@gmail.com    | password | password              | true      |
    | patient  | Tom        | Brady     | tomb2@gmail.com  | password | password              | false     |
    | patient  | Steven     | Jobs      | sj@gmail.com     | password | password              | false     |
    | patient  | Tim        | Cook      | tc@gmail.com     | password | password              | false     |
    | guest    | Guest      | Guest     | guest@guest.com  | password | password              | false     |

    Then The number of patients should be 5

Scenario: Patient views their own profile
  Given I am logged in as "Tom"
  And I click "Patient"
  And I click "Profile"
  Then I should be at the profile of "Tom"

Scenario: Doctor should be able to view patient profiles
  When I am on the searchPatients home page
  And I click "Tom Brady Info"
  Then I should be at the profile of "Tom"

Scenario: Doctor should be able to go to the edit page of patient profiles
  When I am on the searchPatients home page
  And I click "Tom Brady Info"
  And I click "Edit Profile"
  Then I should be at the editing page of "Tom"
