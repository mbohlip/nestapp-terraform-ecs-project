#!/bin/bash

# Download and extract Flyway
sudo wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.0.1/flyway-commandline-10.0.1-linux-x64.tar.gz | tar -xvz

# Create a symbolic link to make Flyway accessible globally
sudo ln -s $(pwd)/flyway-10.0.1/flyway /usr/local/bin

# Create the SQL directory for migrations
sudo cd flyway-10.0.1/
sudo mkdir sql

# Download the migration SQL script from AWS S3
aws s3 cp s3://mpn-rentzone-webfiles/V1__nest.sql

# Run Flyway migration
sudo flyway -url=jdbc:mysql://"${RDS_ENDPOINT}"/"${RDS_DB_NAME}" \
  -user="${USERNAME}" \
  -password="${PASSWORD}" \
  -locations=filesystem:sql \
  migrate

# Then shutdown after waiting 7 minutes
sudo shutdown -h +7


sudo flyway -url=jdbc:mysql://"mpn-rds-db.chvdwpajaz0u.us-east-1.rds.amazonaws.com:3306"/"applicationdb" \
  -user="mpn84" \
  -password="password123" \
  -locations=filesystem:sql \
  migrate