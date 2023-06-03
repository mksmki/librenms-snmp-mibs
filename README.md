# SNMP MIBs database in Python format

[Logstash SNMP Plugin](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-snmp.html)

```bash
# Convertion command
smidump --level=1 -k -f python RFC1213-MIB > RFC1213-MIB.dic
```

### Script for single vendor convertion

Copy `convert-vendor.sh` bash script to `/opt/` directory and make it executable

### Initial convertion

```bash
cd /opt/librenms/mibs
for FILE in $(ls -l | grep -vE '^d' | awk '{print $9}'); do smidump --level=1 -k -f python $FILE > /opt/librenms/dictionaries/${FILE}.dic; done
```

### Bulk convertion

```bash
cd /opt/librenms/mibs
for DIR in $(ls -l | grep -E '^d' | awk '{print $9}'); do /opt/convert-vendor.sh $DIR; done
```
