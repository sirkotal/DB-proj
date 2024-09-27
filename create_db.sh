#!/bin/env bash

if [[ -e "./test.db" ]]; then
    echo "Database already exists"
    exit 1
fi

sqlite3 ./test.db < ./criar.sql
sqlite3 ./test.db < ./povoar.sql

echo "Database Created"
