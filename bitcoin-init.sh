#!/bin/sh
set -e

PRUNE="${BITCOIN_PRUNE:-550}"
DATADIR="${BITCOIN_DATADIR:-/blockchain}"

#Setting folders and rights
mkdir -p $DATADIR
chmod 700 $DATADIR
chown -R bitcoin $DATADIR

exec gosu bitcoin bitcoind -prune=$PRUNE -datadir=$DATADIR
