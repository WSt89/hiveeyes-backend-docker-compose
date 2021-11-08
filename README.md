# Hiveeyes Backend with Docker


## About
Run complete [Hiveeyes] backend using Docker Compose.


## Usage


### Acquire repository

```shell
git clone https://github.com/hiveeyes/hiveeyes-backend-docker
cd hiveeyes-backend-docker
```

### Start backend services

The full stack will also provide support for CSV import (MongoDB needed) and
LoRaWAN/TTN transport. This will start Kotori, Mosquitto, InfluxDB, Grafana,
MongoDB, Redis and PutsReq.
```shell
docker-compose --file=docker-compose-full.yml pull
docker-compose --file=docker-compose-full.yml up
```


### Data acquisition examples

To observe what's going on on the MQTT bus, subscribe to all topics:
```shell
mosquitto_sub -t '#' -v
```

Prepare a measurement reading:
```shell
CHANNEL=hiveeyes/testdrive/site-42/hive-01
DATA='{"temperature": 42.84, "humidity": 83.1}'
```

Submit reading using MQTT:
```shell
MQTT_BROKER=localhost
echo "$DATA" | mosquitto_pub -h $MQTT_BROKER -t $CHANNEL/data.json -l
```

Submit reading using HTTP:
```shell
HTTP_URI=http://localhost:24642/api
echo "$DATA" | curl --request POST --header 'Content-Type: application/json' --data @- $HTTP_URI/$CHANNEL/data
```

Submit reading in CSV format using HTTP:
```shell
# 1. Send field names once
echo '## temperature, humidity' | http POST $HTTP_URI/$CHANNEL/data Content-Type:text/csv

# 2. Send reading
echo '30.30, 67.67' | http POST $HTTP_URI/$CHANNEL/data Content-Type:text/csv
```

### Data export examples

```shell
http $HTTP_URI/$CHANNEL/data.csv

HTTP/1.1 200 OK
Channel-Id: /hiveeyes/testdrive/site-42/hive-01
Content-Disposition: inline; filename=testdrive_site_42_hive_01_20210719T191039_20210729T191039.csv
Content-Length: 221
Content-Type: text/csv; charset=utf-8
Date: Thu, 29 Jul 2021 19:10:39 GMT
Server: TwistedWeb/20.3.0
Target-Address-Scheme: influxdb
Target-Address-Uri: hiveeyes_testdrive
Target-Database: hiveeyes_testdrive
Target-Expression: SELECT * FROM site_42_hive_01_sensors WHERE time >= '2021-07-19 19:10:39.766' AND time <= '2021-07-29 19:10:39.766';

time,humidity,temperature
2021-07-29T18:48:40.560716Z,83.1,42.84
2021-07-29T18:48:47.529965Z,83.1,42.84
2021-07-29T18:48:52.683115Z,83.1,42.84
2021-07-29T18:49:27.007852Z,67.67,30.3
2021-07-29T19:01:51.354883Z,67.67,30.3
```

## Documentation

Please enjoy reading the Kotori documentation about further details of data
acquisition and -export.

- https://getkotori.org/docs/#examples
- https://getkotori.org/docs/handbook/acquisition/protocol/mqtt.html
- https://getkotori.org/docs/handbook/acquisition/protocol/http.html
- https://getkotori.org/docs/handbook/export/

For learning some details about Grafana, please visit:

- https://grafana.com/docs/grafana/latest/getting-started/getting-started-influxdb/
- https://grafana.com/docs/grafana/latest/datasources/influxdb/
- https://grafana.com/docs/grafana/latest/dashboards/

Learning about the Influx Query Language (InfluxQL) and the Flux data scripting language:

- https://docs.influxdata.com/influxdb/v1.8/query_language/
- https://docs.influxdata.com/influxdb/v1.8/flux/

Last but not least, you might want to learn something about MQTT and the Mosquitto broker:

- https://mqtt.org/
- https://mosquitto.org/


## Interfaces

### Grafana
Grafana will be accessible on http://localhost:3000/, the default credentials
are `admin/admin`.

When prompted by Grafana to set a new password (you can also skip this step),
please make sure to adjust the section `[grafana]` in
`volumes/kotori/conf/kotori.ini` accordingly.

### MQTT
Mosquitto will be accessible on localhost:1883. By default, anonymous access is
allowed. When aiming to lock down access to the MQTT broker, see next section.

### HTTP
The HTTP API is available at localhost:24642. Access to HTTP is currently not
restricted. A solution can be to configure authentication within an upstream
HTTP reverse proxy like Nginx or Apache.

### PutsReq
A PutsReq instance is available at http://localhost:5050/.


## Operations

### Lock down MQTT broker

In order to enable authentication for the MQTT broker and allow authenticated
access only, follow these steps:

- Set `allow_anonymous false` in `volumes/mosquitto/conf/mosquitto.conf` in
  order to deny anonymous access to the MQTT broker.
- Add MQTT credentials for all of your members by invoking
  `mosquitto_passwd -b volumes/mosquitto/conf/mosquitto.passwd username password`.
- When changing the MQTT credentials for user `kotori`, please make sure to
  adjust the section `[mqtt]` in `volumes/kotori/conf/kotori.ini` accordingly.

### Communicate between containers
When aiming to communicate between container instances, please address their
hostnames as outlined within the `services` section of the `docker-compose.yml`
file. For example, to configure the database URI in Grafana to access InfluxDB,
use `http://influxdb:8086/`.


## Credits

Many thanks to Werner Sturm (@WSt89) and all authors of the thousands of
software components embedded into this system.


## Development

You are welcome to join the development discussion at
https://community.hiveeyes.org/t/running-the-hiveeyes-backend-with-docker-compose/3505.


[Hiveeyes]: https://hiveeyes.org/
