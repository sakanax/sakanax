require 'sakanax'
require 'thor'
require 'octokit'
require 'tty-spinner'
require_relative 'github'

module Sakanax
  # CLI Class
  class CLI < Thor
    class_option 'sha', type: :string, required: true
    class_option 'config', type: :string, required: false

    def initialize(*args)
      super
      config = File.join(Dir.pwd, '.sakanax.yml') if config.nil?
      @github = Github.new(config)
      @sha = options['sha']
      spinner = TTY::Spinner.new(':spinner ', format: :dots_2)
      spinner.auto_spin
    end

    default_command :pull_requests
    desc 'pull_requests', \
         'A list of PullRequests containing the target commit ID (sha).'
    def pull_requests
      p @github.get_pull_requests_contained_target_commit_id(options['sha'])
    end

    desc 'diff_files', \
         'Detect files included in the PullRequests ' \
         'containing the target commit ID (sha).'
    def diff_files
      pull_requests = @github.get_pull_requests_contained_target_commit_id(@sha)
      pull_requests.each do |pr|
        p "PullRequest: #{pr}, diff files: #{github.get_files_with_changes(pr)}"
      end
    end

    desc 'detect_file', \
         'It judges whether there is a file to be searched in PullRequest. ' \
         'If the file exists, it will return the list of the specified file. ' \
         'If the file can not be found, false is returned.'
    def detect_file
      detect_files = @github.detect_file(@sha)
      p detect_files.empty? ? false : detect_files
    end
  end
end
