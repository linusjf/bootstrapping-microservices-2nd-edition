#!/usr/bin/env bash

######################################################################
# @author      : Linus Fernandes (linusfernandes at gmail dot com)
# @file        : assign-acr-roles
# @created     : Thursday Sep 18, 2025 18:27:17 IST
#
# @description :
######################################################################

# 🔧 Customize these
ASSIGNEE="$1" # e.g. user@domain.com or SPN client ID
ACR_NAME="$2" # e.g. myregistry

# Get full ACR resource ID
SCOPE=$(az acr show --name "$ACR_NAME" --query id --output tsv)

echo "Assigning roles to $ASSIGNEE for ACR: $ACR_NAME ($SCOPE)"

# 1. AcrPull
az role assignment create \
  --assignee "$ASSIGNEE" \
  --role acrpull \
  --scope "$SCOPE"

# 2. AcrPush
az role assignment create \
  --assignee "$ASSIGNEE" \
  --role acrpush \
  --scope "$SCOPE"

# 3. AcrDelete
az role assignment create \
  --assignee "$ASSIGNEE" \
  --role acrdelete \
  --scope "$SCOPE"

# 4. AcrReader
az role assignment create \
  --assignee "$ASSIGNEE" \
  --role acrreader \
  --scope "$SCOPE"

echo "✅ All 4 roles assigned successfully!"
