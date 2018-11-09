require "sakanax"
require "thor"
require "octokit"
require "tty-spinner"
require_relative 'github'

module Sakanax
  class CLI < Thor
    class_option "sha", :type => :string, required: true
    class_option "config", :type => :string, required: false

    default_command :pull_requests
    desc "pull_requests", "A list of PullRequests containing the target commit ID (sha)."
    def pull_requests
      github = Github.new(options['config'])
      p github.get_pull_requests_contained_target_commit_id(options['sha'])
    end

    desc "diff_files", "Detect files included in the PullRequests containing the target commit ID (sha)."
    def diff_files
      github = Github.new(options['config'])
      pull_requests =  github.get_pull_requests_contained_target_commit_id(options['sha'])
      pull_requests.each do |pr|
        p "PullRequest: #{pr}, diff files: #{github.get_files_with_changes(pr)}"
      end
    end

    desc "detect_file", "abc"
    def detect_file
      spinner = TTY::Spinner.new(":spinner Searching files on GitHub PullRequest :spinner", format: :dots_2)
      spinner.auto_spin

      github = Github.new(options['config'])
      detect_files = github.detect_file(options['sha'])
      spinner.stop('\nDone!')
      p detect_files.empty? ? false : detect_files
    end
  end
end
