#!/bin/bash

ls -al /docker-entrypoint.*

/docker-entrypoint.d/extract-archive.sh

exit 0
