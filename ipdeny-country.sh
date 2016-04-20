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

ZONEDIR=/opt/ipdeny
IPDENY_URL=http://www.ipdeny.com/ipblocks/data/countries
COUNTRY=br

if [ "$1x" == "x" ]; then
	fail "You didn't specify the country list you want"
else
	COUNTRY=$1
	echo "Download list for country: ${COUNTRY}"
fi

if [ ! -d ${ZONEDIR} ]; then
	mkdir -m 755 -pv ${ZONEDIR} || \
		fail "Failed to create zone directory"
fi

wget --no-verbose -t 3 \
	-O ${ZONEDIR}/${COUNTRY}.zone.new \
	${IPDENY_URL}/${COUNTRY}.zone || \
	fail "Failed to download zone file"

mv -fv -- ${ZONEDIR}/${COUNTRY}.zone.new \
	${ZONEDIR}/${COUNTRY}.zone || \
	fail "Failed to update zone file"

exit 0
