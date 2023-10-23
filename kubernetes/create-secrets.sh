#!/usr/bin/env bash
set -euo pipefail

kubectl create secret generic insights-app -n default --from-literal=webhook_secret="$GH_INSIGHTS_WEBHOOK_SECRET"
