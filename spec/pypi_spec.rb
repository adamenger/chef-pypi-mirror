require 'spec_helper'

describe user('pypi') do
  it { should exist }
end

describe file('/etc/bandersnatch.conf') do
  it { should be_file }
end

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/nginx/sites-enabled/pypi_mirror') do
  it { should be_file }
  it { should contain "server_name" }
end

# make sure our cronjobs are ready to go
describe cron do
  it { should have_entry '*/2 * * * * /mnt/pypi/env/bin/bandersnatch mirror' }
  it { should have_entry '12 * * * * /mnt/pypi/env/bin/bandersnatch update-stats' }
end

