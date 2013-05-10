#!/bin/bash
. /etc/environment
app=$1; config=$2; log=$3;
cd $app && /var/www/puma/current/bin/puma -C $config 2>&1 >> $log