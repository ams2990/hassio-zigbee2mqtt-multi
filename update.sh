#!/bin/bash
git pull --rebase=merges -X ours upstream master
rm -rf zigbee2mqtt*
git restore --source upstream/master zigbee2mqtt/
for x in {a..c}; do
  cp -R zigbee2mqtt zigbee2mqtt-${x};
  sed -i \
    -e "s#\"8485/tcp\": 8485,#\"8485/tcp\": null,#" \
    -e "s#\"name\": \"Zigbee2MQTT\"#\"name\": \"Zigbee2MQTT (${x^^})\"#" \
    -e "s#\"slug\": \"zigbee2mqtt\"#\"slug\": \"zigbee2mqtt-${x}\"#" \
    -e "s#\"data_path\": \"/config/zigbee2mqtt\"#\"data_path\": \"/config/zigbee2mqtt-${x}\"#" \
    zigbee2mqtt-${x}/config.json
done
rm -rf zigbee2mqtt/
git add --all
git commit -m 'Sync with upstream'
git push --force
