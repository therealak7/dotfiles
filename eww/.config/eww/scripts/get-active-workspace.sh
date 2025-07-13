#!/usr/bin/env bash
niri msg --json workspaces | jq '.[] | select(.is_focused == true ) | .idx'
#
# MAP_FILE="/tmp/niri_ws_map"
#
# update_workspace_map() {
#     niri msg --json workspaces | jq -r '.[] | "\(.id) \(.idx)"' > "$MAP_FILE"
# }
#
# #Initialize workspace map
# update_workspace_map

#Start event stream to get workspace index
# while IFS= read -r id; do
#     echo "ID: $id"
# done < <(niri msg --json event-stream | jq 'select(.WorkspaceActivated) | .WorkspaceActivated.id')
niri msg --json event-stream | jq 'select(.WorkspaceActivated) | .WorkspaceActivated.id'

# niri msg --json event-stream | jq -c 'select(.WorkspaceActivated) | .WorkspaceActivated.id' | while read -r id; do idx=$(awk -v id="$id" '$1 == id { print $2 }' "$MAP_FILE")
#
#   # If not found, update the map and try again
#   if [ -z "$idx" ]; then
#     update_workspace_map
#     idx=$(awk -v id="$id" '$1 == id { print $2 }' "$MAP_FILE")
#   else
#     echo "no idx"
#   fi
#
#   # Output or use the workspace index
#   if [ -n "$idx" ]; then
#     echo "Workspace ID: $id → Index: $idx"
#     # Example: eww update current_ws="$idx"
#   else
#     echo "Workspace ID $id not found even after refreshing." >&2
#   fi
# done
#
#
