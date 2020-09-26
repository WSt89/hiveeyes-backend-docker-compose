# hiveeyes-backend-docker-compose
run [Hiveeyes](https://hiveeyes.org/) backend via docker-compose

## How to use:
<ol>
  <li>run <code>initVolumes.sh</code> to create folder structure for persisting configurations, data and logs</li>
  <li>edit/add config files</li>
  <li>generate <code>mosquitto.passwd</code> file by running <code>mosquitto_passwd -c mosquitto.passwd <username></code> and place it into <em>volumes/mosquitto/conf</em></li>
  <li>edit <code>.env</code> file</li>
  <li>run <code>sudo docker-compose</code></li>
</ol>

## missing features:
- grafana persistence
