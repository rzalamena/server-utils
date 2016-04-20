# server-utils

This is a colletion of scripts to manage or improve your server OS utilities.

Feel free to use them to create or improve your own scripts or management tools.

## ipdeny-country.sh

Creates directory /opt/ipdeny and downloads the list of networks for that country.

## load-zone.sh

Creates the network hash named after the country and loads all networks provided by the
list of networks of ipdeny.

This is usefull if you want to block whole countries or only allow yours with your firewall.

On Linux (iptables) you might use like this:

```
# iptables -t filter -A INPUT -p tcp --dport 22 -m set --match-set br src -j DROP
```

or try it for a few seconds like:
```
# iptables -t filter -I INPUT 1 -p tcp --dport 22 -m set ! --match-set br src -j DROP && sleep 5 && iptables -t filter -D INPUT 1
```

On OpenBSD or others OSes using PF you might use the \<table\> functions to achieve the same.

## ban-address.sh

Adds the specified address to a ban list that can be run as a shell script.


# Special thanks to ipdeny.com

For providing this lists and it's rule generator.

Link:
http://www.ipdeny.com
