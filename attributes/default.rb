# run mirroring commands as node[:pypi][:username]
default[:pypi][:username] = 'pypi'
default[:pypi][:groupname] = 'pypi'

# which domain to serve requests for e.g: pypi.threadless.com
default[:pypi][:domain] = 'localhost'

# install dependencies into node[:pypi][:install_directory]
default[:pypi][:install_directory] = '/mnt/pypi'

# mirror files into
default[:pypi][:mirror_directory] = '/mnt/pypi/data'
