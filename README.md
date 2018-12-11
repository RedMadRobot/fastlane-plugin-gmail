# gmail plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-gmail)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-gmail`, add it to your project by running:

```bash
fastlane add_plugin gmail
```

## About gmail

Send mail from gmail.

Authentication options:
- Username and password - specify options FL_GMAIL_USERNAME and FL_GMAIL_PASSWORD.<br>
[G Suite](https://support.google.com/a/answer/176600?hl=en) documentation, see Gmail SMTP server.
> if you use two-factor authentication, create a password for the application. [Sign in using App Passwords](https://support.google.com/accounts/answer/185833?hl=en)

- Auth by IP for G Suite accounts. You should configure your G Suite account and specify option FL_GMAIL_DOMAIN.<br>
See documentation [SMTP relay](https://support.google.com/a/answer/2956491?hl=en).


## Options

| Key      | Description              | Env Var           | Default   |
|----------|--------------------------|-------------------|-----------|
| domain   | G Suite domain           | FL_GMAIL_DOMAIN   | gmail.com |
| username | Username for gmail       | FL_GMAIL_USERNAME |           |
| password | Password for gmail       | FL_GMAIL_PASSWORD |           |
| to       | Mail to recipients       | FL_GMAIL_TO       |           |
| subject  | The subject of the email | Fl_GMAIL_SUBJECT  |           |
| body     | The body of the email    | Fl_GMAIL_BODY     |           |


## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
