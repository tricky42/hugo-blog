#!/bin/bash
#set -e

DISTRIBUTION_ID=E2YIH0V7R37ABN
BUCKET_NAME=bucksteeg.de-cdn

hugo -v

## Copy over pages - not static js/img/css/downloads
aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$BUCKET_NAME/ --exclude 'images' --exclude 'js' --exclude 'downloads' --exclude 'css' --exclude 'scss' --exclude '.DS_Store' --delete

## Ensure static files are set to cache forever - cache for a month --cache-control "max-age=2592000"
aws s3 sync --cache-control "max-age=2592000" --acl "public-read" --sse "AES256"  --delete public/assets/ s3://$BUCKET_NAME/assets/

## Invalidate landing page so everything sees new post - warning, first 1K/mo free, then 1/2 cent ea
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths /index.html /