require 'chefspec'

describe 'pypi::default' do
  let (:chef_run) {
    #Chef::Recipe.any_instance.stub(:apt_repository)
    ChefSpec::ChefRunner
      .new({:step_into => ['python_requirements', 'python_virtualenv'],
           :log_level => :debug})
      .converge 'pypi::default'
  }

  it 'should include python' do
    expect(chef_run).to include_recipe 'python::default'
  end

  it 'should create a pypi directory' do
    expect(chef_run).to create_directory '/mnt/pypi'
  end

  it 'should create a requirements file' do
    expect(chef_run).to create_file '/mnt/pypi/requirements.txt'
  end

  it 'should create a virtualenv' do
    expect(chef_run).to execute_command 'virtualenv --python=python  /mnt/pypi/env'
  end

  it 'should install dependencies' do
    expect(chef_run).to execute_command '/mnt/pypi/env/bin/pip install --upgrade --requirement \'/mnt/pypi/requirements.txt\''
  end

  it 'should create a data directory for all the pypi packages' do
    expect(chef_run).to create_directory '/mnt/pypi/data'
  end

  it 'should install lighttpd' do
    expect(chef_run).to install_package 'nginx'
  end

  it 'should install a lighttpd vhost' do
    expect(chef_run).to create_file '/etc/nginx/sites-enabled/pypi_mirror'
  end

  it 'should setup cron to run bandersnatch mirror periodically' do
    expect(chef_run).to create_cron 'pypi_mirror'
  end

  it 'should setup cron to run bandersnatch update-stats periodically' do
    expect(chef_run).to create_cron 'pypi_stats'
  end

  it 'should start the lighttpd service' do
    expect(chef_run).to restart_service 'nginx'
  end

  it 'should install a bandersnatch config' do
    expect(chef_run).to create_file '/etc/bandersnatch.conf'
  end

end
