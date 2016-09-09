[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html) [![Build Status](https://travis-ci.org/simp/pupmod-simp-sudosh.svg)](https://travis-ci.org/simp/pupmod-simp-sudosh) [![SIMP compatibility](https://img.shields.io/badge/SIMP%20compatibility-4.2.*%2F5.1.*-orange.svg)](https://img.shields.io/badge/SIMP%20compatibility-4.2.*%2F5.1.*-orange.svg)

# sudosh

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with sudosh](#setup)
    * [What sudosh affects](#what-sudosh-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sudosh](#beginning-with-sudosh)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Acceptance Tests](#acceptance-tests)

## Module Description

This class installs sudosh and configures rsyslog and logrotate.

## Setup

### What sudosh affects

Sudosh installs sudosh, configures rsyslog for sudosh logging, and logrotates
the sudosh user data

### Setup Requirements

`simp/rsyslog` and `simp/logrotate` must be present to use sudosh.

### Beginning with sudosh 

This module can be used by simply including the sudosh class.

## Usage

### I want to ensure that my admins use sudosh specifically

To ensure admins use sudosh, so that actions are logged this is best performed
with the `simp/sudo` module, by creating a sudo rule that ONLY allows admins to
use sudosh.

Example:
```puppet
sudo::user_specification { 'global_admin':
  user_list => '%administrators',
  host_list => 'ALL',
  runas => 'ALL',
  cmnd => '/usr/bin/sudosh',
  passwd => 'false'
}
```

## Reference

### Classes

#### Public Classes

* `sudosh`

### Class: `sudosh`

This class has no parameters or options

## Limitations

SIMP Puppet modules are generally intended to be used on a Red Hat Enterprise
Linux-compatible distribution.

## Development

Please read our [Contribution Guide](https://simp-project.atlassian.net/wiki/display/SD/Contributing+to+SIMP)
and visit our [Developer Wiki](https://simp-project.atlassian.net/wiki/display/SD/SIMP+Development+Home)

If you find any issues, they can be submitted to our
[JIRA](https://simp-project.atlassian.net).

## Acceptance tests

To run the system tests, you need `Vagrant` installed.

You can then run the following to execute the acceptance tests:

```shell
   bundle exec rake beaker:suites
```

Some environment variables may be useful:

```shell
   BEAKER_debug=true
   BEAKER_provision=no
   BEAKER_destroy=no
   BEAKER_use_fixtures_dir_for_modules=yes
```

*  ``BEAKER_debug``: show the commands being run on the STU and their output.
*  ``BEAKER_destroy=no``: prevent the machine destruction after the tests
   finish so you can inspect the state.
*  ``BEAKER_provision=no``: prevent the machine from being recreated.  This can
   save a lot of time while you're writing the tests.
*  ``BEAKER_use_fixtures_dir_for_modules=yes``: cause all module dependencies
   to be loaded from the ``spec/fixtures/modules`` directory, based on the
   contents of ``.fixtures.yml``. The contents of this directory are usually
   populated by ``bundle exec rake spec_prep``. This can be used to run
   acceptance tests to run on isolated networks.
