# Use the official TigerBeetle image as base (minimal Alpine Linux)
FROM ghcr.io/tigerbeetle/tigerbeetle:latest

# Install bash for scripting (Alpine default is ash, but bash is more reliable for conditionals)
RUN apk add --no-cache bash

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port (for Render service config)
EXPOSE 3000

# Set entrypoint to handle format-then-start
ENTRYPOINT ["/entrypoint.sh"]
