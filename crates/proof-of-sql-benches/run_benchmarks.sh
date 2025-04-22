#!/bin/bash

# Ensure the script runs in its current directory
cd "$(dirname "$0")"

# Create a "data" directory if it doesn't already exist
mkdir -p data

# Get the current timestamp in the format "YYYY-MM-DD_HH-MM-SS"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Export the CSV_PATH environment variable
export CSV_PATH="$(pwd)/data/results_${TIMESTAMP}.csv"
echo "Saving results at: ${CSV_PATH}"

# Define the schemes and table sizes to iterate over
SCHEMES=("hyper-kzg")
TABLE_SIZES=(1000000 10000000 100000000 268435456) # 268435456 is 2^28, which is the maximum Powers of Tau

# Run the benchmarks for each scheme and table size
for SCHEME in "${SCHEMES[@]}"; do
  for TABLE_SIZE in "${TABLE_SIZES[@]}"; do
      echo "Running benchmark for scheme: $SCHEME, table size: $TABLE_SIZE"
      cargo run --release --bin proof-of-sql-benches -- -s "$SCHEME" -t "$TABLE_SIZE"
  done
done
