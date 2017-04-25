# nodejs.pp

Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

exec { "download_setup_script":
    command => "curl -o /opt/nodesource_setup.sh -sL https://deb.nodesource.com/setup_6.x",
    creates => "/opt/nodesource_setup.sh",
    timeout => "1200"
}

file {"/opt/nodesource_setup.sh":
    ensure => present,
    owner  => "root",
    mode   => "0775"
}

exec {"setup_nodejs":
    command => "bash /opt/nodesource_setup.sh",
    #creates => ""
}

package {"nodejs":
    require => Exec[""]
}

exec { "npm_install_pm2":
    require => Exec[""],
    command => "npm install pm2 -g",
    creates => "/usr/bin/pm2"
}

  
  
  
  
  
  
  
  
