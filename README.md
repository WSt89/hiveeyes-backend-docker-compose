# hiveeyes-backend-docker-compose
run [Hiveeyes](https://hiveeyes.org/) backend via docker-compose

## How to use:
<ol>
  <li>run <code>init-volumes.sh</code> to create folder structure for persisting configurations, data and logs</li>
  <li>edit/add config files</li>
  <li>generate <code>mosquitto.passwd</code> file by running <code>mosquitto_passwd -c mosquitto.passwd <username></code> and place it into <em>volumes/mosquitto/conf</em></li>
  <li>configure mosquitto credentials in <code>kontori.ini</code></li>
  <li>set userid in <code>docker-compose.yml</code> to provide persistence permissions to grafana</li>
  <li>edit <code>.env</code> file (optional)</li>
  <li>run <code>sudo docker-compose up</code></li>
</ol>

## missing features:
- grafana persistence
