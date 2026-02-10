#!/bin/bash
# Top 5 IP addresses with the most requests:
# 45.76.135.253 - 1000 requests
# 142.93.143.8 - 600 requests
# 178.128.94.113 - 50 requests
# 43.224.43.187 - 30 requests
# 178.128.94.113 - 20 requests

# Top 5 most requested paths:
# /api/v1/users - 1000 requests
# /api/v1/products - 600 requests
# /api/v1/orders - 50 requests
# /api/v1/payments - 30 requests
# /api/v1/reviews - 20 requests

# Top 5 response status codes:
# 200 - 1000 requests
# 404 - 600 requests
# 500 - 50 requests
# 401 - 30 requests
# 304 - 20 requests

# IP address
# Date and time
# Request method and path
# Response status code
# Response size
# Referrer
# User agent

# awk, sort, uniq, head
# grep, sed

LOG_FILE="./nginx-logs.log"

echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -r | head -n 5 | while read -r count ip ; do
  echo "$ip - $count requests";
done

echo "\nTop 5 most requested paths:"
awk -F'"' '{print $2}' "$LOG_FILE" | sort | awk '{print $2}' | uniq -c | sort -r | head -n 5 | while read -r count path; do
  echo "$path - $count requests"
done

echo "\n Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -r | head -n 5 | while read -r count code; do
  echo "$code - $count requests"
done

echo "Top 5 IP addresses with the most requests: (grep sed)"
grep 
done

