#TEDx Brisbane

[![Code Climate](https://codeclimate.com/github/net-engine/tedx-brisbane.png)](https://codeclimate.com/github/net-engine/tedx-brisbane)
[![Coverage Status](https://coveralls.io/repos/net-engine/tedx-brisbane/badge.png)](https://coveralls.io/r/net-engine/tedx-brisbane)

We're building an [application](https://github.com/net-engine/tedx-brisbane) for TEDx Brisbane. You can see the site it will [replace](http://www.tedxbrisbane.com/).

Generally, the system will allow people to learn about the event, and register their interest in attending. An admin will be able to invite people in batches, at which time they can purchase a ticket. This invitation should expire, so that another batch of people may be invited. This may go through multiple rounds of invitations.

## Roadmap
### Design
- add static content to public page
- email content
- html emails
- rails controller for emails (display this in a browser etc)

### Development
- update invitation email to include links to pay / decline
- send emails on registration
- update admin batch actions to include missing events
  - invite (done)
  - remind (done)
  - revoke (manual, not via the timer) (done)
  - pay (for giving away free tickets) (done)
  - confirm (manual by an admin, not via email link) (done)
  - decline (manual by an admin, not via email link) (done)
- update active_admin for rails 4
- ditch unnecessary fields from active_admin (tokens, for example)
