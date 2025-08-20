#!/bin/bash

USER=ec2-user
HOST=ec2-16-171-139-160.eu-north-1.compute.amazonaws.com
KEY=~/Projects/personal.pem
SOURCE=./static-site/
TARGET=/var/www/static-site/

rsync -avz -e "ssh -i $KEY" $SOURCE $USER@$HOST:$TARGET
