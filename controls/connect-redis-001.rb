control 'connect-redis-001' do
  impact 1.0
  title 'Check if inspec can pass commands to redis'
  desc 'execute redis-cli set key command, to check connectivity of the service'

  only_if do
    command('redis-cli').exist?
  end

  describe command('redis-cli SET test_inspec "HELLO"') do
    its(:stdout) { should match(/OK/) }
  end
end