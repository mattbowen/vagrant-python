class lucid32 {
  package { "git-core":
    ensure => present,
  }

  package { "zlib1g-dev":
    ensure => present,
  }

  package { "libfreetype6-dev":
    ensure => present,
  }

  package { "libjpeg62-dev":
    ensure => present,
  }

  package { "liblcms1-dev":
    ensure => present,
  }
   
  package { "subversion":
    ensure => present,
  }

}

include lucid32
