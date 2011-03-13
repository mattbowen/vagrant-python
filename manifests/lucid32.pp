Exec{path=>"/usr/bin:/usr/sbin"}
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
	"libreadline5-dev": ensure => present;
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
  "libbz2-dev": ensure => present;
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
class checkoutbuildout {
  subversion::working-copy {
    "buildout":
      path => "/opt/python",
      branch => "python/",
      owner => "root",
      group => "root",
      repo_base => "svn.plone.org/svn/collective",
      require => Package["python-setuptools"];
  }
}

class buildpythons {
  include checkoutbuildout
  exec { "/usr/bin/python2.6 /opt/python/bootstrap.py --distribute  && /opt/python/bin/buildout":
      user => "root",
      cwd => "/opt/python",
      path => "/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin",
      timeout => 7200,
      require => [Class["checkoutbuildout"],Class["python"],Class["pildeps"]],
      creates => "/opt/python/bin/buildout",
      logoutput => on_failure,
      
  }

}
class { "aptupdate": stage => "update"}
class { "python": stage => "pre" }
class { "pildeps": stage => "pre" }
class { "vcs": stage => "pre" }

class lucid32 {
  include aptupdate
  include python
  include pildeps
  include vcs
  include buildpythons
  

}

include lucid32
