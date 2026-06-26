#!/bin/bash

# This script will dump JSON representations of all Cloudwatch dashboards.
# Run it like this:
#
#   aws-vault exec prod-analytics -- ./dump_dashboards.sh

set -euo pipefail

# Read dashboard names into the array
DASHBOARDS=$(aws cloudwatch list-dashboards --query 'DashboardEntries[*].DashboardName' --output text)

# Loop through each dashboard
for dashboard in $DASHBOARDS
do
    # Get the dashboard details and save to a file
    echo "Getting $dashboard..."
    aws cloudwatch get-dashboard --dashboard-name "$dashboard" --query 'DashboardBody' --output text > "${dashboard}.json"
done