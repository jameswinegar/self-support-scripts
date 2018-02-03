#!/usr/bin/env bash

# move desktop, scripts, and service files to appropriate locations
for FOLDER in Tibia Hashicorp
do
  rsync -avzh --include='*/' --include="*.desktop" --exclude="*" $FOLDER/ /usr/share/applications/
  rsync -avzh --include='*/' --include="*.sh" --exclude="*" $FOLDER/ /usr/local/bin/
  rsync -avzh --include='*/' --include="*.service" --exclude="*" $FOLDER/ /etc/systemd/system/
done

# create an array of all services
declare -a array
find . -name "*.service" -exec basename {} \; > /tmp/tmpfile
readarray -t array < /tmp/tmpfile
rm -f /tmp/tmpfile

# for each service, enable and start the service
for SERVICE in "${array[@]}"
do
  systemctl enable $SERVICE
  systemctl start $SERVICE
done