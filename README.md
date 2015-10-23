[![Build Status](https://travis-ci.org/olistik/mail_stats.svg)](https://travis-ci.org/olistik/mail_stats)

# Mail Stats

This is a web app that collects e-mail events sent from Mandrill Webhooks.

## Requirements

- Redis

## Data Collection

Just do POST requests to `/email_events`, inserting in the body the JSON representation of the parameters.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/olistik/mail_stats. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The web application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
