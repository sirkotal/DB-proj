#!/bin/env bash

rm ./test.db
bash ./create_db.sh

sqlite3 test.db