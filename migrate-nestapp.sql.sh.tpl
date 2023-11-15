#!/bin/bash

# Download and extract Flyway
sudo wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.0.0/flyway-commandline-10.0.0-linux-x64.tar.gz | tar -xvz

# Create a symbolic link to make Flyway accessible globally
sudo ln -s $(pwd)/flyway-10.0.0/flyway /usr/local/bin

# Create the SQL directory for migrations
sudo mkdir sql

# Download the migration SQL script from AWS S3
aws s3 cp s3://mpn-rentzone-webfiles/rentzone-db.sql/

# Run Flyway migration
sudo flyway -url=jdbc:mysql://"${RDS_ENDPOINT}"/"${RDS_DB_NAME}" \
  -user="${USERNAME}" \
  -password="${PASSWORD}" \
  -locations=filesystem:sql \
  migrate

# Then shutdown after waiting 7 minutes
sudo shutdown -h +7