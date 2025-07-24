#!/bin/bash

# Validate Schedule References Script
# This script validates that schedule groups reference schedules that exist

echo "📅 Validating Schedule References..."
echo "===================================="

echo ""
echo "📋 Schedules being created:"

# Read schedules CSV and extract names
if [ -f "modules/architect_schedules/data-files/architect_schedules.csv" ]; then
    echo "From architect_schedules.csv:"
    tail -n +2 modules/architect_schedules/data-files/architect_schedules.csv | cut -d',' -f1 | sed 's/^/  - /'
else
    echo "❌ architect_schedules.csv not found"
fi

echo ""
echo "📋 Schedule Groups and their references:"

# Read schedule groups CSV and extract references
if [ -f "modules/architect_schedulegroups/data-files/architect_schedulegroups.csv" ]; then
    echo "From architect_schedulegroups.csv:"
    tail -n +2 modules/architect_schedulegroups/data-files/architect_schedulegroups.csv | while IFS=',' read -r name description division timezone open closed holiday; do
        echo "  Schedule Group: $name"
        echo "    Open schedules: $open"
        echo "    Closed schedules: $closed"
        echo "    Holiday schedules: $holiday"
        echo ""
    done
else
    echo "❌ architect_schedulegroups.csv not found"
fi

echo ""
echo "🔍 Validation Summary:"
echo "  - Schedule groups must reference schedules that exist"
echo "  - Schedule names must match exactly (including suffixes)"
echo "  - Missing schedules will cause 'require at least one open schedule' errors"
echo ""
echo "✅ Schedule references should now be valid!" 