

This is a serverspec-based test-suite for hardening Docker hosts. It covers a number of aspects on the host and the configuration of a docker daemon.
It's aspects are configurable, i.e. if TLS is not used, all TLS-based checks can be disabled. It fits nicely in a test driven approach where 
serverspec is already used as system and configuration management validation.

## Prerequisites

* Ruby (1.9.3+)
* Bundler

## Install

```bash
$ git clone https://github.com/de-wiring/tests-docker-hardening.git
$ cd tests-docker-hardening
$ bundle install
```

Bundler will install rake, serverspec and some dependencies. After that serverspec's can be executed.

## Usage

Rakefile will scan for all directories in CWD and build a serverspec task for it. The `default` directory can be used right away:

```bash
# bundle exec serverspec:default
(...)
```

This will normally throw a lot of spec errors, since not all aspects are needed.
The Spec is divided in sections
* 1: host level
* 2: daemon configuration
* 3: additional daemon configuration files

## Configuration

It is possible to disable individual sections and subsections. The `spec_helper_hardening.rb` contains methods for modifying section content, controllable by environment variables, i.e. DH_DISABLE_CAT disables sections by category.
Possible values for categories are:
* **tls** No checks for TLS certs and keys
* **systemd** No checks for systemd-related configuration and files
* **docker-registry** No checks for docker systemd registry services
* **docker-network** No checks for docker systemd network services
* **docker-storage** No checks for docker systemd storage services

```bash
# DH_DISABLE_CAT="tls systemd" bundle exec rake serverspec:default
```


## License

Copyright 2015 Andreas Schmidt

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
