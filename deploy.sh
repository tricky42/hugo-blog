#!/bin/bash
#set -e

DISTRIBUTION_ID=E2YIH0V7R37ABN
BUCKET_NAME=bucksteeg.de-cdn

hugo -v

## Copy over pages - not static js/img/css/downloads
echo "**************************************"
echo "Syncing content (no binary content)..."
echo "**************************************"
aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$BUCKET_NAME/ --exclude 'images' --exclude 'js' --exclude 'css' --exclude 'less' --exclude 'css' --exclude 'tr2017/*' --exclude '.DS_Store' --delete

echo "**************************************"
echo "Syncing binary content (no content)..."
echo "**************************************"
## Ensure static files are set to cache forever - cache for a month --cache-control "max-age=2592000"
aws s3 sync --cache-control "max-age=2592000" --acl "public-read" --sse "AES256"  --delete public/ s3://$BUCKET_NAME/ --exclude "*" --include 'images' --include 'js' --include 'css' --include 'less' --include 'css' --delete


echo "**************************************"
echo "Invalidating Cloudfront"
echo "**************************************"
## Invalidate landing page so everything sees new post - warning, first 1K/mo free, then 1/2 cent ea
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*""