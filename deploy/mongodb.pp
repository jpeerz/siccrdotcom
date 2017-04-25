# Based on https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

Exec {
    path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

$mongodb_version = "3.4",
$lsb_release = "xenial"

exec { "install_mongodb_key":
    command => "sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6",
    onlyif  => "test $(apt-key list | grep mongodb | wc -l) -eq 0"
}

exec { "install_mongodb_repo":
    command => "echo 'deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu $lsb_release/mongodb-org/${mongodb_version} multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-${mongodb_version}.list",
    creates => "/etc/apt/sources.list.d/mongodb-org-${mongodb_version}.list",
    require => Exec["install_mongodb_key"]
}

exec { "update_ubuntu_mongodb_repos":
    command => "sudo apt-get update > /dev/null",
    creates => "/var/run/mongodb.pid",
    require => [Exec["install_mongodb_repo"],Exec["install_mongodb_key"]]
}

package { "mongodb-org":
    ensure  => installed,
    require => Exec["update_ubuntu_mongodb_repos"]
}

