require "sakanax"
require "thor"
require "octokit"
require_relative 'github'

module Sakanax
  class CLI < Thor

    default_command :pull_requests
    desc "pull_requests", "A list of PullRequests containing the target commit ID (sha)."
    option "sha", required: true
    def pull_requests
      github = Github.new
      p github.get_pull_requests_contained_target_commit_id(options['sha'])
    end

    desc "diff_files", "Detect files included in the PullRequests containing the target commit ID (sha)."
    option "sha", required: true
    def diff_files
      github = Github.new
      pull_requests =  github.get_pull_requests_contained_target_commit_id(options['sha'])
      pull_requests.each do |pr|
        p "PullRequest: #{pr}, diff files: #{github.get_files_with_changes(pr)}"
      end
    end

    desc "detect_file", "abc"
    option "sha", required: true
    def detect_file
      github = Github.new
      detect_files = github.detect_file(options['sha'])
      p detect_files.empty? ? '[INFO] Anything detcted.' : "[INFO] detected #{detect_files}"
    end
  end
end
