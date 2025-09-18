#!/usr/bin/env bash

######################################################################
# @author      : Linus Fernandes (linusfernandes at gmail dot com)
# @file        : list-acr-repos
# @created     : Thursday Sep 18, 2025 18:50:49 IST
#
# @description :
######################################################################

# Replace with your registry name
ACR_NAME="$1"

# List all repositories
echo "Repositories in $ACR_NAME:"
REPOS=$(az acr repository list --name "$ACR_NAME" --output tsv)

if [ -z "$REPOS" ]; then
  echo "No repositories found."
  exit 0
fi

for REPO in $REPOS; do
  echo "----------------------------------------"
  echo "Repository: $REPO"

  # List tags for each repository
  TAGS=$(az acr repository show-tags --name "$ACR_NAME" --repository "$REPO" --output tsv)

  if [ -z "$TAGS" ]; then
    echo "  No tags found."
  else
    echo "  Tags:"
    for TAG in $TAGS; do
      echo "    - $TAG"
    done
  fi
done
