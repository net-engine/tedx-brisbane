#TEDx Brisbane

[![Code Climate](https://codeclimate.com/github/net-engine/tedx-brisbane.png)](https://codeclimate.com/github/net-engine/tedx-brisbane)
[![Coverage Status](https://coveralls.io/repos/net-engine/tedx-brisbane/badge.png)](https://coveralls.io/r/net-engine/tedx-brisbane)

We're building an [application](https://github.com/net-engine/tedx-brisbane) for TEDx Brisbane. You can see the site it will [replace](http://www.tedxbrisbane.com/).

Generally, the system will allow people to learn about the event, and register their interest in attending. An admin will be able to invite people in batches, at which time they can purchase a ticket. This invitation should expire, so that another batch of people may be invited. This may go through multiple rounds of invitations.

## Event Configuration

* Update data for `Event` in `config/initializers/constants.rb`
* Update text for the event in `config/en.yml`
* Update text for emails in `view/emails/_*.haml`
* Update server ips in `config/deploy/production/{{env}}`
* Update `db/database.yml` and create a new database
* Use `config/seed.rb` for admins


## Roadmap
### Design
- add static content to public page
- email content and design

### Development
- rails controller for emails (display this in a browser etc)
- update active_admin for rails 4 (currently quite hacky)

### Bundling
If you're having troubles bundling checkout the work in progress branch `updating_gems_to_allow_bundle`

## Sidekiq

Even in developement emails are sent through a background job, you'll need redis and start
the server with `bundle exec sidekiq -C config/sidekiq.yml`

## Westpack

* [Go to the Westpac site](https://www.payway.com.au/cards/APISecurityView)
* Setup Api (if missing ask the client to setup api access)
* Setup Api - Downloads: get the certificate `.pem` (PHP)
* Setup Api - Security: Add prod and local ip and the production one
* Setup Api - Security: Get the customer credentials
* Administration - Merchant: Get the merchant ID (TEST for test)
* Update `config/payway.yml` (DON'T COMMIT, copy on the server)
* [Check test ccs here](https://www.payway.com.au/downloads/WBC/PayWay_API_Developers_Guide.pdf)
* Setup API - Go live

