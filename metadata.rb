name             'pypi-mirror'
maintainer       'Adam Enger'
maintainer_email 'adamenger@gmail.com'
license          'BSD'
description      'Installs/Configures pypi mirror'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'python'
depends 'nginx'
depends 'apt'
