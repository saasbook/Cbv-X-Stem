## Background Information
- CvbXStem is a growing stem cell treatment clinic. This project would consist of creating a website that would have a patient portal, for patients to contact their doctors through the portal (link to email or WhatsApp) and have access to any important forms they need to fill in. Then, we would need the admin portal, where admins/doctors could have access to all patient’s treatment information, be able to track a patient’s treatment process and be able to update it, send reminder emails or send forms to be completed.

### Link to Archor Post for Information
- https://app.slack.com/docs/TG6K00C7J/FPKEM4HJ9?origin_team=TG6K00C7J
- Most up-to-date Heroku: https://stormy-brushlands-94689.herokuapp.com/
- Backups: https://intense-beach-00160.herokuapp.com (Main Version), https://salty-headland-17719.herokuapp.com (Backup Version)
- TravisCI setup: https://travis-ci.com/KunalBasu20/cbvxstem

<a href="https://codeclimate.com/github/KunalBasu20/cbvxstem/maintainability"><img src="https://api.codeclimate.com/v1/badges/b9b542d73d0de4b2fdd0/maintainability" /></a>

<a href="https://codeclimate.com/github/KunalBasu20/cbvxstem/test_coverage"><img src="https://api.codeclimate.com/v1/badges/b9b542d73d0de4b2fdd0/test_coverage" /></a>

<a href="https://travis-ci.com/KunalBasu20/cbvxstem"><img src="https://travis-ci.com/KunalBasu20/cbvxstem.svg?branch=master" alt="Build Status" />

#### TravisCI and CodeClimate badges
This repo is the "original" repo. This repo was then forked to a "Downstream" repo by a different team member; the downstream repo has this repo as the upstream. TravisCI and CodeClimate are set up with respect to what is in the downstream repo. In order to update the CodeClimate and TravisCI badges, you need to go to the downstream repo and pull from the upstream repo using `git pull upstream master`. Apologies for any confusion.


- https://travis-ci.org/nathanielng2017/cbvxstem

<!-- <a href="https://codeclimate.com/github/nathanielng2017/cbvxstem/maintainability"><img src="https://api.codeclimate.com/v1/badges/06c38654042d71e88d11/maintainability" /></a> -->

<!-- <a href="https://codeclimate.com/github/nathanielng2017/cbvxstem/test_coverage"><img src="https://api.codeclimate.com/v1/badges/06c38654042d71e88d11/test_coverage" /></a> -->

<!-- <a href="https://travis-ci.org/nathanielng2017/cbvxstem"><img src="https://travis-ci.org/nathanielng2017/cbvxstem.svg?branch=master" alt="Build Status" /> -->

#### Notice: Enabling email notifications
- To enable email notifications, you may need to change the security setting of the admin email to avoid the `Net::SMTPAuthenticationError`. First, go to https://myaccount.google.com/lesssecureapps to allow less secure apps. If that doesn't work, go to http://www.google.com/accounts/DisplayUnlockCaptcha and click continue. This will grant access for 10 minutes for registering new apps.
- The admin email address and password can be found in `db/seeds.rb`, `config/environments/production.rb`, and `config/environments/development.rb` (below `config.action_mailer.smtp_settings`). If you want to change the admin email, then you need to change all these fields correspondingly, as well as the email address shown on the Contact page (`app\views\pages\contact.html.erb`), and the email address receiving contacts (`app\controllers\users\messages_controller.rb`-> `create`-> `@message.receiver_email`).

#### Tests
Currently there are a great number of accessibility tests that have been commented out because they rely on geckodriver, which can be found here: https://github.com/mozilla/geckodriver/releases

In order to make these tests run, first download the appropriate geckodriver file for your computer. Then you will need to move the geckodriver file into the correct path; for most Mac users, this is under `usr/local/bin`. Once geckodriver has been moved to the correct location, tests should be able to run smoothly. 

**Note: as far as we can tell, geckodriver accessibility tests are not supported by TravisCI.** Please be aware.
