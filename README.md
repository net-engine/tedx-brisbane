#TEDx Brisbane

[![Coverage Status](https://coveralls.io/repos/net-engine/tedx-brisbane/badge.png)](https://coveralls.io/r/net-engine/tedx-brisbane)

We're building an [application](https://github.com/net-engine/tedx-brisbane) for TEDx Brisbane. You can see the site it will [replace](http://www.tedxbrisbane.com/).

Generally, the system will allow people to learn about the event, and register their interest in attending. An admin will be able to invite people in batches, at which time they can purchase a ticket. This invitation should expire, so that another batch of people may be invited. This may go through multiple rounds of invitations.

## User Stories
- As a user, I want to browse static content related to the event without signing in
- As a user, I want to use a "contact us" form
- As a user, I want to register my interest in purchasing a ticket
- As a user, I want to purchase a ticket with my credit card
- As an admin, I want to see a list of all users, filterable by their status
- As an admin, I want to see the details of a particular users
- As an admin, I want to invite batches of users to purchase tickets.
- As a user, I want to receive an email "Thanks for registering"
- As a user, I want to receive an email "You've been invited to purchase a ticket"
- As a user, I want to receive an email "Sorry, your invitation has been passed on to someone else"
- As a user, I want to receive an email "Here's another chance to purchase a ticket"
- As a user, I want to receive an email "Thanks for purchasing a ticket"
- As a user, I want to receive an email "A reminder before the event"

### RSpec
- We'll write tests for everything, and [CircleCI](http://circleci.com/) will make our staging deploys
- The [RSpec book](http://it-ebooks.info/book/77/) is invaluable. Buy it. Read it.
- The [Relish docs](https://www.relishapp.com/rspec) are also a great place to learn.

### Mandrill
- We'll use existing Mailchimp templates where possible
- [https://mandrillapp.com/api/docs/](https://mandrillapp.com/api/docs/)

### State Machine (for User statuses)
- awaiting_first_invitation
- received_first_invitation
- awaiting_second_invitation
- received_second_invitation
- awaiting_third_invitation
- received_third_invitation
- paid
- received_reminder
- confirmed
- declined
- [https://github.com/pluginaweek/state_machine](https://github.com/pluginaweek/state_machine)

### Sidekiq
- delivers emails via worker jobs
- a scheduled job rekoves stale invitations
- a scheduled job sends a reminder for the event
- [https://github.com/mperham/sidekiq/wiki/Testing](https://github.com/mperham/sidekiq/wiki/Testing)

### Active Admin
- for the admin area, listing users, filtering by status etc.
- for batch actions, such as sending invitations.
- [http://activeadmin.info/docs](http://activeadmin.info/docs)

### Braintree
- For taking secure payments
- [https://www.braintreepayments.com/docs/ruby/guide/overview](https://www.braintreepayments.com/docs/ruby/guide/overview)

### API / Push notifications / Live queuing information
- We'll use [Handlebars](http://handlebarsjs.com/) templates for a live dashboard of the number of people of each status.
- We'll use [Pusher](http://pusher.com/docs) to keep these up-to-date in all connected clients.
- We'll write an API using [active-model-serializers](https://github.com/rails-api/active_model_serializers) to feed this dashboard.
- [https://github.com/leshill/handlebars_assets](https://github.com/leshill/handlebars_assets)
