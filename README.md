# Sakanax <img class="avatar" src="https://user-images.githubusercontent.com/20736455/48205670-effe4300-e3af-11e8-8cfd-7078f8965e1f.png" width="44" height="44">

[![Gem Version](https://badge.fury.io/rb/sakanax.svg)](https://badge.fury.io/rb/sakanax)

Sakanax is a CLI tool for identifying files that are up in Github PullRequest. For example, specifying a commit ID specifies a PullRequest including the commit ID, and also acquires a list of files included in the PullRequest.


## Usage

First, Specify Github's access token and repository name as an environment variable and put .sakanax.yml in your project root directory.

##### Github token / repository

```bash
$ export GITHUB_TOKEN=<personal access token>
$ export GITHUB_REPOSITORY=<your repository name>
```

##### .sakanax.yml

```yaml
detect_files:
  - "src/main/file.rb"
  - "lib/etc.rb"
  - ....
```

### help

```bash
$ sakanax help
⣾ Commands:
  sakanax detect_files --sha=SHA   # It judges whether there is a file to be searched in PullRequest.
  sakanax diff_files --sha=SHA     # Detect files included in the PullRequests containing the target commit ID (sha).
  sakanax help [COMMAND]           # Describe available commands or one specific command
  sakanax pull_requests --sha=SHA  # A list of PullRequests containing the target commit ID (sha).
  sakanax version                  # version

Options:
  -h, [--help], [--no-help]  # help message.
      [--config=CONFIG]
```

### pull_requests
A list of PullRequests containing the target commit ID (sha).
```bash
$ sakanax pull_requests --sha 536ad1c5c6e5a675122eb0fdcb4ac5da06def098
[3, 2, 1]
```

### diff_files
Detect files included in the PullRequests containing the target commit ID (sha).
```bash
$ sakanax diff_files --sha c5c6e5a6756def0986ad1122eb0a0fdcb4ac5d53
"PullRequest: 32, diff files: ['diff file1', 'diff file2', ...]"
```  

### detect_file
Put .sakanax.yml in your project root directory. Detect file in .sakanax.yml.

```bash
$ sakanax detect_file --sha aed28c5aa60398fda946878978168890b0x0007a
"[INFO] detected [[\"lib/sakanax/cli.rb\"]]"

$ sakanax detect_file --sha 17ff60e38f98aed28c5aa60398fda94687897816
"[INFO] target commit ID (sha: 17ff60e38f98aed28c5aa60398fda94687897816) does not exist in the currently open PullRequests."
"[INFO] Anything detcted.
```

### Actual Usage
Based on the result of sakanax detect_files command, it judges whether to test the target file.

```bash
#!/bin/bash

RESULT=$(sakanax detect_files --sha <COMMIT ID> --config .sakanax.yml)

if [ "${RESULT}" == false ]; then
  echo "Could not find the file contained in .sakanax.yml."
else
  echo "Test the detected file"
  # ...
  # ...
fi
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sakanax'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sakanax


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sakanax/sakanax. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sakanax project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sakanax/blob/master/CODE_OF_CONDUCT.md).
