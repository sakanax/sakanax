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

    desc "files", "Detect files included in the PullRequests containing the target commit ID (sha)."
    option "sha", required: true
    def diff_files
      github = Github.new
      pull_requests =  github.get_pull_requests_contained_target_commit_id(options['sha'])
      pull_requests.each do |pr|
        p "PullRequest: #{pr}, diff files: #{github.get_files_with_changes(pr)}"
      end
    end

  end
end
