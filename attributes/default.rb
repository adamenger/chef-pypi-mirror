# run mirroring commands as node[:pypi][:username]
default[:pypi][:username] = 'pypi'
default[:pypi][:groupname] = 'pypi'

# install dependencies into node[:pypi][:install_directory]
default[:pypi][:install_directory] = '/mnt/pypi'

# mirror files into
default[:pypi][:mirror_directory] = '/mnt/pypi/data'
