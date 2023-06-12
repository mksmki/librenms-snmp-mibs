# Configuration example for Logstash SNMP plugin

[Documentation](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-snmp.html)
[Linux SNMP OID’s for CPU, Memory and Disk Statistics](http://www.linux-admins.net/2012/02/linux-snmp-oids-for-cpumemory-and-disk.html)

```
# Example
# snmpget -v3 -l authNoPriv -u "${snmp_username}" -a MD5 -A "${snmp_password}" 127.0.0.1 1.3.6.1.2.1.1.1.0
input {
  snmp {
    hosts => [{host => "udp:127.0.0.1/161" version => "3"}]
    mib_paths => "/usr/share/logstash/mibs/mibs"
    get => [
      "1.3.6.1.2.1.1.1.0",
      "1.3.6.1.2.1.1.3.0",
      "1.3.6.1.2.1.1.5.0",
      "1.3.6.1.4.1.2021.10.1.3.1",
      "1.3.6.1.4.1.2021.10.1.3.2",
      "1.3.6.1.4.1.2021.10.1.3.3",
      "1.3.6.1.4.1.2021.4.11.0"
    ]
    security_name => "${snmp_username}"
    auth_protocol => "md5"
    auth_pass => "${snmp_password}"
    security_level => "authNoPriv"
  }
}

filter {
  mutate {
    add_field => { "[data_stream][type]" => "logs" }
    add_field => { "[data_stream][dataset]" => "snmp.logs" }
    add_field => { "[data_stream][namespace]" => "network" }
  }
}

output {
  elasticsearch {
    hosts => ["http://elasticsearch:9200"]
    index => "network-snmp-%{+YYYY.MM.dd}"
    # cacert => '/etc/logstash/config/certs/ca.crt'
    user => '${logstash_username}'
    password => '${logstash_password}'
  }
}
```
