#!/bin/sh

set -e

gpg --import ~/gpg-public.asc
gpg --import ~/gpg-private.asc
gpg --import-ownertrust ~/gpg-ownertrust.txt
