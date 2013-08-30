Pypi Cookbook
=============

This cookbook sets up a mirror of pypi.python.org using the bandersnatch utility.

Requirements
------------
#### Operating System:
Currently this cookbook is only designed to run on Debian/Ubuntu.

#### Cookbooks:

I require the following cookbooks:

 - python

#### Misc

Due to the subdirectory limitations of ext3(32k) we ran into some issues deploying a pypi mirror on ext3.
Please keep this in mind and plan accordingly, we've successfully deployed to ext4.

Attributes
----------
* `default[:pypi][:username]` - User to run pypi as
* `default[:pypi][:groupname]` - Group to run pypi as
* `default[:pypi][:install_directory]` - Install directory(pypi, virtualenv)
* `default[:pypi][:mirror_directory]` - Mirror into this directory

Usage
-----
#### pypi::default

Just include `pypi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pypi]"
  ]
}
```

Tests
-----
#### rspec
`rspec spec/default_spec.rb`


License and Authors
-------------------
Authors: technology@skinnycorp.com, adamenger@gmail.com
