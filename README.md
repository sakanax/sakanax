# Sakanax

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/sakanax`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sakanax'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sakanax

## Usage

```
$ sakanax help
Commands:
  sakanax diff_files --sha=SHA     # Detect files included in the PullRequests containing the target commit ID (sha).
  sakanax help [COMMAND]           # Describe available commands or one specific command
  sakanax pull_requests --sha=SHA  # A list of PullRequests containing the target commit ID (sha).
```

### pull_requests
A list of PullRequests containing the target commit ID (sha).
```
$ sakanax pull_requests --sha 536ad1c5c6e5a675122eb0fdcb4ac5da06def098
[3, 2, 1]
```

### diff_files
Detect files included in the PullRequests containing the target commit ID (sha).
```
$ sakanax diff_files --sha c5c6e5a6756def0986ad1122eb0a0fdcb4ac5d53
"PullRequest: 32, diff files: ['diff file1', 'diff file2', ...]"
```  

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sakanax. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sakanax project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sakanax/blob/master/CODE_OF_CONDUCT.md).
