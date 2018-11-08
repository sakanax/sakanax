require "sakanax"
require "thor"
require "octokit"
require_relative 'github'

module Sakanax
  class CLI < Thor
    desc "files", "Detect files included in the PullRequest."
    def files
      puts "detect files.."

      github = Github.new
      github.get_pull_requests
    end
  end
end
