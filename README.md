Pypi Cookbook
=============

This cookbook sets up a mirror of pypi.python.org using the bandersnatch utility. Nginx is installed to serve an autoindex on your pypi mirror directory.

Requirements
------------
#### Operating Systems:
This cookbook has been tested on CentOS 6.4 and Ubuntu 12.04. 

#### Cookbooks:

I require the following cookbooks:

 - python
 - nginx
 - apt

#### Misc

Due to the subdirectory limitations of ext3(32k) we ran into some issues deploying a pypi mirror on ext3.
Please keep this in mind and plan accordingly, we've successfully deployed to ext4.

Attributes
----------
* `default[:pypi][:domain]` - Domain for NGINX to listen for requests
* `default[:pypi][:username]` - User to run pypi as
* `default[:pypi][:groupname]` - Group for pypi user
* `default[:pypi][:install_directory]` - Install directory(pypi, virtualenv)
* `default[:pypi][:mirror_directory]` - Mirror into this directory

Usage
-----
#### pypi::default

Just include `pypi-mirror` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pypi-mirror]"
  ]
}
```

Tests
-----
#### rspec
`rspec spec/*_spec.rb`


License and Authors
-------------------
Authors: technology@skinnycorp.com, adamenger@gmail.com
