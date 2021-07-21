control 'operating_system' do
  title "Check that OS is Ubuntu"
  desc "Verifies the name of the operating system on the targeted host"
  describe command('lsb_release -a') do
    its('stdout') { should match (/Ubuntu/) }
  end
end
