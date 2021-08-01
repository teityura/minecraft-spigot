#!/bin/sh

CSV_FILE='/plugins.csv'
if [ ! -e "$CSV_FILE" ]; then
  exit 0
fi

plugins_csv=`cat $CSV_FILE | sed '1d'`

for line in ${plugins_csv}; do
  plugin_url=`echo ${line} | cut -d, -f2`
  plugin_name=`echo ${line} | cut -d, -f3`

  if [ -e "$plugin_name" ]; then
    echo "${plugin_name} already exists"

  else
    echo "${plugin_name} doesn't exist yet"
    wget $plugin_url -O $plugin_name
  fi

done

exit 0
