package { 'ntp': ensure => installed }
file { 'ntp.conf':
path => '/etc/ntp.conf',
mode => '0641',
content => '
driftfile /var/lib/ntp/ntp.drift
statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable
server 0.pool.ntp.org
server 1.pool.ntp.org
restrict -4 default kod notrap nomodify nopeer noquery
restrict -6 default kod notrap nomodify nopeer noquery
restrict 127.0.0.1
restrict ::1
',
require => Package[ntp],
}

service { 'ntp':
ensure => 'running',
enable => 'true',
pattern => 'ntpd',
subscribe => [Package['ntp'], File['/etc/ntp.conf']],
}

