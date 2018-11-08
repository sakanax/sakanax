require 'yaml'

class Github

  def initialize()
    @client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
    @repository = ENV['GITHUB_REPOSITORY']

    config = File.join(ENV['HOME'], ".sakanax.yml")
    @yaml = YAML.load_file(config)
  end

  # Open状態のPullRequestの一覧を配列で取得する
  def get_opened_pull_requests()
    pull_requests = @client.pull_requests(@repository)

    opened_pull_requests = Array.new
    pull_requests.each do |pr|
      opened_pull_requests.push(pr[:number])
    end
    return opened_pull_requests
  end

  # コミットID(sha)を含むPullRequestの一覧を配列で取得する
  def get_pull_requests_contained_target_commit_id(sha)
    pull_requests_contained_target_commit_id = Array.new
    get_opened_pull_requests().each do |pr|
      @client.pull_request_commits(@repository, pr).each do |commit|
        pull_requests_contained_target_commit_id.push(pr) if sha == commit[:sha]
      end
    end
    p "[INFO] target commit ID (sha: #{sha}) does not exist in the currently open PullRequests." if pull_requests_contained_target_commit_id.empty?
    return pull_requests_contained_target_commit_id
  end

  # テスト対象とするPRの番号から、変更があったファイルを抽出する
  def get_files_with_changes(pull_request)
    files = Array.new
    @client.pull_request_files(@repository, pull_request).each do |file|
      files.push(file[:filename])
    end
    p '[INFO] No file changed in the specified PullRequest' if files.empty?
    return files
  end

  def detect_file(sha)
    pr = get_pull_requests_contained_target_commit_id(sha)
    files = get_files_with_changes(pr)
    duplicated_files = files & yaml["detect_files"]
    p duplicated_files
  end
end
