#!/bin/bash
#
# Copyright (c) 2016 Rafael Zalamena <rzalamena@gmail.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

fail()
{
	echo "F: $1"
	exit 1
}

COUNTRY=br
ZONEFILE=/opt/ipdeny/${COUNTRY}.zone

if [ "$1x" == "x" ]; then
	fail "You didn't specify the country list you want"
else
	COUNTRY=$1
	echo "Loading list for country: ${COUNTRY}"
fi

if [ ! -f ${ZONEFILE} ]; then
	fail "Zone file ${ZONEFILE} doesn't exist"
fi

ipset create ${COUNTRY} hash:net >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "IPSET already existis, flusing..."
	ipset flush ${COUNTRY} || \
		fail "Failed to flush ipset ${COUNTRY}"
fi

for i in $(cat ${ZONEFILE}); do
	ipset add ${COUNTRY} $i || \
		fail "Failed to add all rules"
done

exit 0
