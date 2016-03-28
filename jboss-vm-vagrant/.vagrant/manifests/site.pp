class { 'timezone':
    timezone => 'Europe/Moscow',
}

class { 'locales':
    locales  => ['ru_RU.UTF-8 UTF-8'],
}
class apt_install {
    exec {'update':
        command => 'apt-get update',
        path    => '/usr/bin',
        timeout => 0,
    } ->
    package {[
              'vim',
            ]:
            ensure  => installed,
    }
 }
class java_install {
    class { "java":
    }
}
class jboss_install {
  class { 'jboss':
		install             => 'source',
		disable  => ''
	}
	jboss::instance { 'inst01':
		  createuser => false, # Default user jboss is already created by jboss class
		  bindaddr    => '127.0.0.1',
		  port        => '8080',
	}
}

include apt_install
include timezone
include locales
include java_install
include jboss_install