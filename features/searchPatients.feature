Feature: search patients as doctor

  As an doctor
  So that I can quickly search patients by user_id, first_name and last_name
  I want to see the patients matching the search query

Background: patients have been added to database

  Given the following patients exist:
  | first_name | last_name | email           | password | password_confirmation |
  | Peter      | Pei       | pp2@gmail.com   | password | password              |
  | Tom        | Brady     | tomb2@gmail.com | password | password              |

  Then The number of patients should be 2

#TO DO define paths and find the patients
Scenario: search Patients by first name: