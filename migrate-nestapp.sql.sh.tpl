#!/bin/bash

# Download and extract Flyway
sudo wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.0.1/flyway-commandline-10.0.1-linux-x64.tar.gz | tar -xvz

# Create a symbolic link to make Flyway accessible globally
sudo ln -s $(pwd)/flyway-10.0.1/flyway /usr/local/bin

# Create the SQL directory for migrations
mkdir sql

# Download the migration SQL script from AWS S3
sudo aws s3 cp s3://${S3_BUCKET_NAME}/${SQL_FILE} sql/

# Run Flyway migration
sudo flyway -url=jdbc:mysql://${RDS_ENDPOINT}/${RDS_DB_NAME} \
  -user=${USERNAME} \
  -password=${PASSWORD} \
  -locations=filesystem:sql \
  migrate

# Then shutdown after waiting 5 minutes
sudo shutdown -h +5

# mpn-rds-db.chvdwpajaz0u.us-east-1.rds.amazonaws.com