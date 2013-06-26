#TEDx Brisbane

[![Code Climate](https://codeclimate.com/github/net-engine/tedx-brisbane.png)](https://codeclimate.com/github/net-engine/tedx-brisbane)
[![Coverage Status](https://coveralls.io/repos/net-engine/tedx-brisbane/badge.png)](https://coveralls.io/r/net-engine/tedx-brisbane)

We're building an [application](https://github.com/net-engine/tedx-brisbane) for TEDx Brisbane. You can see the site it will [replace](http://www.tedxbrisbane.com/).

Generally, the system will allow people to learn about the event, and register their interest in attending. An admin will be able to invite people in batches, at which time they can purchase a ticket. This invitation should expire, so that another batch of people may be invited. This may go through multiple rounds of invitations.

## Roadmap
### Design
- add static content to public page
- email content
- html emails (IN PROGRESS)
- update invitation email to include links to pay / decline
- rails controller for emails (display this in a browser etc)

### Development
- send emails on registration
- update admin batch actions to include missing events
  - invite (DONE)
  - remind (DONE)
  - revoke (manual, not via the timer) (DONE)
  - pay (for giving away free tickets) (DONE)
  - confirm (manual by an admin, not via email link) (DONE)
  - decline (manual by an admin, not via email link) (DONE)
- ditch unnecessary fields from active_admin (tokens, for example) (DONE)
- update active_admin for rails 4
