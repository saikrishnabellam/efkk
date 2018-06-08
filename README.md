# Docker EFK stack

Based on the official images:

* [elasticsearch](https://github.com/elastic/elasticsearch-docker)
* [kibana](https://github.com/elastic/kibana-docker)

Default configuration of Search Guard in this repo is:

* Basic authentication required to access Elasticsearch/Kibana
* HTTPS disabled
* Hostname verification disabled
* Self-signed SSL certificate for transport protocol (do not use in production)

Existing users:

* admin (password: admin): No restrictions for this user, can do everything
* fluentd (password: fluentd): CRUD permissions for fluentd index
* kibanaro (password: kibanaro): Kibana user which can read every index
* kibanaserver (password: kibanaserver): User for the Kibana server (all permissions for .kibana index)

# Requirements

## Increase `vm.max_map_count` on your host

You need to increase the `vm.max_map_count` kernel setting on your Docker host.
To do this follow the recommended instructions from the Elastic documentation: [Install Elasticsearch with Docker](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode)

# Usage

Start the ELK stack using *docker-compose*:
docker-compose up -d

## Important
 Search Guard must be initialized after Elasticsearch is started:

```bash
$ docker exec elasticsearch bin/init_sg.sh
```

_This executes sgadmin and load the configuration in elasticsearch/config/sg*.yml_


Access Kibana UI by hitting [http://localhost:5601](http://localhost:5601) with a web browser and use the following credentials to login:

* user: *kibanaro*
* password: *kibanaro*

Refer to the [`sg_internal_users.yml`](elasticsearch/config/sg_internal_users.yml) configuration file for a list of built-in users.
And refer to [`sg_roles.yml and sg_roles_mapping.yml '] for the access levels of built-in users

By default, the stack exposes the following ports:
* 24224: Fluentd TCP input.
* 9200: Elasticsearch HTTP
* 9300: Elasticsearch TCP transport
* 5601: Kibana

# Configuration

*NOTE*: Configuration is not dynamically reloaded, you will need to restart the stack after any change in the configuration of a component.

## How can I tune Kibana configuration?

The Kibana default configuration is stored in `kibana/config/kibana.yml`.

## How can I tune Elasticsearch configuration?

The Elasticsearch container is using the [shipped configuration](https://github.com/elastic/elasticsearch-docker/blob/master/build/elasticsearch/elasticsearch.yml).

If you want to override the default configuration, create a file `elasticsearch/config/elasticsearch.yml` and add your configuration in it.

Then, you'll need to map your configuration file inside the container in the `docker-compose.yml`. Update the elasticsearch container declaration to:

```yml
elasticsearch:
  build: elasticsearch/
  volumes:
    - ./elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
```

You can also specify the options you want to override directly via environment variables:

## How can I add plugins?

To add plugins to any EFK component you have to:

1. Add a `RUN` statement to the corresponding `Dockerfile` (eg. `RUN logstash-plugin install logstash-filter-json`)
2. Add the associated plugin code configuration to the service configuration (eg. Logstash input/output)

