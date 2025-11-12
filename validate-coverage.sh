#!/bin/bash

# Validate Newman Test Coverage
# Requires: jq, bc

RESULTS_FILE="newman-results.json"
THRESHOLD=80

if [ ! -f "$RESULTS_FILE" ]; then
    echo "❌ Error: $RESULTS_FILE not found"
    echo "Run newman with --reporter-json-export first"
    exit 1
fi

# Extract metrics
TOTAL=$(jq '.run.stats.assertions.total' "$RESULTS_FILE")
FAILED=$(jq '.run.stats.assertions.failed' "$RESULTS_FILE")
PASSED=$((TOTAL - FAILED))

# Calculate coverage percentage
if [ "$TOTAL" -eq 0 ]; then
    echo "❌ Error: No assertions found"
    exit 1
fi

COVERAGE=$(awk "BEGIN {printf \"%.2f\", ($PASSED / $TOTAL) * 100}")

# Display report
echo "=========================================="
echo "Test Coverage Report"
echo "=========================================="
echo "Total Assertions: $TOTAL"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Coverage: $COVERAGE%"
echo "Threshold: $THRESHOLD%"
echo "=========================================="

# Validate threshold
if (( $(echo "$COVERAGE < $THRESHOLD" | bc -l) )); then
    echo "❌ FAILED: Coverage $COVERAGE% is below $THRESHOLD% threshold"
    exit 1
else
    echo "✅ PASSED: Coverage $COVERAGE% meets the $THRESHOLD% threshold"
    exit 0
fi
