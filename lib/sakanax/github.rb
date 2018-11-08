class Github

  def initialize()
    @client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
  end

  def get_pull_requests()
    repository_name = 'daisuke-awaji/aws-continuous-integration-flamework'
    pull_requests = @client.pull_requests(repository_name)
    puts pull_requests
  end

  def hello
    puts "hello"
  end
end
