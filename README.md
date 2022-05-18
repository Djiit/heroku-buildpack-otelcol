# OpenTelemetry Collector Heroku Buildpack

This [Heroku buildpack][1] installs OpenTelemetry Collector in your Heroku dyno to collect app metrics and traces.

## Configuration

This buildpack assumes that otel collector config file is located at `/otelcol/config.yml` in your application.

By default, this buildpack installs [OpenTelemetry Collector Core][2], to install [OpenTelemetry Collector Contrib][3], set `OTELCOL_CONTRIB` to `true` in your enviroment variables.

In addition, you can include a prerun script, `/otelcol/prerun.sh`, in your application. 
The prerun script runs after all of the standard configuration actions and immediately before starting OpenTelemetry Collector. 
This allows you to modify the environment variables (for example: $DISABLE_OTELCOL), perform additional configurations, etc.

```shell
#!/usr/bin/env bash

# Disable based on dyno type
if [ "$DYNOTYPE" == "run" ]; then
  DISABLE_OTELCOL="true"
fi

# Update configuration placeholder using the Heroku application environment variable
if [ -n "$RUNTIME_URL" ]; then
  sed -i "s/<URL>/$RUNTIME_URL/" "$APP_OTELCOL/config.yml"
fi
```

## Credits

Most of the code and inspiration comes from the excellent [sendsonar's Prometheus Heroku Buildpack][4]

[1]: https://devcenter.heroku.com/articles/buildpacks
[2]: https://github.com/open-telemetry/opentelemetry-collector
[3]: https://github.com/open-telemetry/opentelemetry-collector-contrib
[4]: https://github.com/sendsonar/heroku-buildpack-prometheus


