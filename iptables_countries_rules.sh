#!/bin/bash
# Copyleft nickollascarvalho@gmail.com
# block countries using iptables based on list with range of ips
 
# download list with range of countries ips
rm -rf /tmp/all-zones*; wget -nc http://www.ipdeny.com/ipblocks/data/countries/all-zones.tar.gz -P /tmp
 
mkdir /tmp/all-zones; tar -xzvf /tmp/all-zones.tar.gz -C $_
 
COUNTRIES_ISO_CODE_LIST=(af cu mo)
 
for country_iso_code in ${COUNTRIES_ISO_CODE_LIST[*]}; do
 
  for country_ip in $( cat /tmp/all-zones/$country_iso_code.zone ); do
    echo creating rules to $( echo $country_iso_code | tr '[:lower:]' '[:upper:]' ) $country_ip
    /sbin/iptables -A INPUT -s $country_ip -m comment --comment "rule to $( echo $country_iso_code | tr '[:lower:]' '[:upper:]' ) country" -j DROP
  done
done
