#TEDx Brisbane

[![Code Climate](https://codeclimate.com/github/net-engine/tedx-brisbane.png)](https://codeclimate.com/github/net-engine/tedx-brisbane)
[![Coverage Status](https://coveralls.io/repos/net-engine/tedx-brisbane/badge.png)](https://coveralls.io/r/net-engine/tedx-brisbane)

We're building an [application](https://github.com/net-engine/tedx-brisbane) for TEDx Brisbane. You can see the site it will [replace](http://www.tedxbrisbane.com/).

Generally, the system will allow people to learn about the event, and register their interest in attending. An admin will be able to invite people in batches, at which time they can purchase a ticket. This invitation should expire, so that another batch of people may be invited. This may go through multiple rounds of invitations.

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

