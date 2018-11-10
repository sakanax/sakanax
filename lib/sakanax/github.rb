require 'yaml'

# Github
class Github
  def initialize(config)
    @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    @repository = ENV['GITHUB_REPOSITORY']
    @yaml = load_config(config)
  end

  # Get a list of PullRequests including commit ID (sha) as an array
  def get_pr_including_target_commit(sha)
    pr_including_target_commit = []
    fetch_opened_pull_requests.each do |pr|
      @client.pull_request_commits(@repository, pr).each do |commit|
        pr_including_target_commit.push(pr) if sha == commit[:sha]
      end
    end
    puts "[INFO] Target sha: #{sha} is not exist in open PullRequests" \
          if pr_including_target_commit.empty?
    pr_including_target_commit
  end

  # Extract the changed file from the number of PR to be tested
  def get_files_with_changes(pull_request)
    files = []
    @client.pull_request_files(@repository, pull_request).each do |file|
      files.push(file[:filename])
    end
    puts '[INFO] No file changed in the specified PullRequest' if files.empty?
    files
  end

  # Checks whether the file to be searched exists
  # in the pull request including the specified commit ID.
  def detect_files(sha)
    duplicated_files = []
    get_pr_including_target_commit(sha).each do |pr|
      duplicated_files.push(get_files_with_changes(pr) & @yaml['detect_files'])
      duplicated_files.flatten!
    end
    duplicated_files
  end

  private

  def load_config(config)
    return YAML.load_file(config) if File.exist?(config)

    puts "[INFO] Config file #{config} does not exist"
    exit 0
  end

  # Get a list of open state PullRequests as an array
  def fetch_opened_pull_requests
    opened_pull_requests = []
    @client.pull_requests(@repository).each do |pr|
      opened_pull_requests.push(pr[:number])
    end
    opened_pull_requests
  end
end
