require 'sakanax'
require 'thor'
require 'octokit'
require 'tty-spinner'
require_relative 'github'

module Sakanax
  # CLI Class
  class CLI < Thor
    class_option :help, type: :boolean, aliases: '-h', desc: 'help message.'
    class_option 'config', type: :string, required: false

    def initialize(*args)
      super
      config = File.join(Dir.pwd, '.sakanax.yml') if config.nil?
      @github = Github.new(config)
      @sha = options['sha']
      spinner = TTY::Spinner.new(':spinner ', format: :dots_2)
      spinner.auto_spin
    end

    desc 'version', 'version'
    def version
      puts "sakanax #{Sakanax::VERSION}"
    end

    option 'sha', type: :string, required: true
    desc 'pull_requests', \
         'A list of PullRequests containing the target commit ID (sha).'
    def pull_requests
      puts @github.get_pr_including_target_commit(options['sha'])
    end

    option 'sha', type: :string, required: true
    desc 'diff_files', \
         'Detect files included in the PullRequests ' \
         'containing the target commit ID (sha).'
    def diff_files
      pull_requests = @github.get_pr_including_target_commit(@sha)
      pull_requests.each do |pr|
        puts "PR: #{pr}, Diff files: #{@github.get_files_with_changes(pr)}"
      end
    end

    desc 'detect_files', \
         'It judges whether there is a file to be searched in PullRequest. '
    long_desc <<-LONGDESC
      If the file exists, it will return the list of the specified file.

      If the file can not be found, false is returned.
    LONGDESC
    option 'sha', type: :string, required: true
    def detect_files
      detect_files = @github.detect_files(@sha)
      puts detect_files.empty? ? false : "Detected files: #{detect_files}"
    end
  end
end
