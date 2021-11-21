#!/usr/bin/env bash

export PATH="$PATH:$HOME/bin"

APP_OTELCOL="/app/otelcol"

PRERUN_SCRIPT="$APP_OTELCOL/prerun.sh"
if [ -e "$PRERUN_SCRIPT" ]; then
  source "$PRERUN_SCRIPT"
fi

if [ -n "$DISABLE_OTELCOL" ]; then
  echo "The OpenTelemetry Collector agent has been disabled. Unset the $DISABLE_OTELCOL or set missing environment variables."
else
  bash -c "otelcol --config $APP_OTELCOL/config.yml 2>&1 &"
fi
