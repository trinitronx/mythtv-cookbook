Description
===========

Installs MythTV in Debian/Ubuntu.

Changes
=======

## v0.0.4:

* Fix problems found in integration test suites due to long-running `apt-get install`s
  * Enable multiverse repo for dependencies
  * Adding `retry_delay` and `retries` params to frontend & backend recipes
  * Fix IOError (closed stream) & Mixlib::ShellOut::CommandTimeout due to long running apt-get commands
  * Removed unsupported centos-64 from test-kitchen platforms
  * Fix apt 404 errors by including mythtv::default & running apt-get update first
* Added serverspec integration tests for mythtv::backend and mythtv::frontend
  * Added default mysql passwd attributes for mythbackend test-kitchen suite

## v0.0.3:

* Expand supported versions of Ubuntu:
  * Intelligently detect the latest version of MythbuntuPPA/mythtv to use based on LSB codename
  * Added MythbuntuPPA library (+rspec tests) for mapping supported platform versions to PPA versions
  * Use apt\_repository LWRP from apt cookbook to add the PPA
* Added cookbook test framework
  * Added chefspec, serverspec, test-kitchen tests (Run via: `rake` or `strainer test`)
  * Use RallySoftware-cookbooks/cookbook-development cookbook test framework gem
  * Added more supported versions of ubuntu to test-kitchen platforms
  * Use [Travis CI](http://travis-ci.org) to automatically run tests for pull-requests & changes to this cookbook
* Minor enhancements
  * Fix metadata
  * Fix Foodcritic warnings: FC007, FC019
  * Cookbook version now specified in VERSION file

## v0.0.2:

* Add link to GitHub repository.

## v0.0.1:

* Initial version.

Contributions
======

The source for this cookbook is hosted on
[GitHub](https://github.com/peplin/mythtv-cookbook). If you have any issues with
this cookbook, please follow up there.

License and Author
==================

* Copyright 2013, Chris Peplin <chris.peplin@rhubarbtech.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
