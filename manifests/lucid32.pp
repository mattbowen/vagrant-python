stage { "update": before => Stage["pre"] }
stage { "pre": before => Stage["main"] }

class aptupdate {
      exec { "/usr/bin/apt-get update":}
}

class python {
    package {
        "build-essential": ensure => latest;
        "python": ensure => "2.6.5-0ubuntu1";
        "python-dev": ensure => "2.6.5-0ubuntu1";
        "python-setuptools": ensure => installed;
	"libssl-dev": ensure => present;
	"python-openssl": ensure => present;
	"sqlite3": ensure => present;
	"libsqlite3-dev": ensure => present;
    }
    exec { "easy_install pip":
        path => "/usr/local/bin:/usr/bin:/bin",
        refreshonly => true,
        require => Package["python-setuptools"],
        subscribe => Package["python-setuptools"],
    }
}

class pildeps {
  package { 
  "zlib1g-dev": ensure => present;
  "libfreetype6-dev": ensure => present;
  "libjpeg62-dev": ensure => present;
  "liblcms1-dev": ensure => present;
  }
}

class vcs {

  package { "git-core":
    ensure => present,
  }

}

class { "update":stage => "update"}
class { "python": stage => "pre" }
class { "pildeps": stage => "pre" }
class { "vcs": stage => "pre" }

class lucid32 {
  include python
  include pildeps
  include vcs

  subversion::working-copy {
    "buildout":
      path => "/opt/python",
      branch => "python/",
      owner => "vagrant",
      group => "vagrant",
      repo_base => "svn.plone.org/svn/collective",
      require => Package["python-setuptools"];
}
  

}

include lucid32
