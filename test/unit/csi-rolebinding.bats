#!/usr/bin/env bats

load _helpers

@test "csi/RoleBinding: disabled by default" {
  cd `chart_dir`
  local actual=$( (helm template \
      --show-only templates/csi-role.yaml  \
      . || echo "---") | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}

@test "csi/RoleBinding: name" {
  cd `chart_dir`
  local actual=$(helm template \
      --show-only templates/csi-rolebinding.yaml \
      --set "csi.enabled=true" \
      . | tee /dev/stderr |
      yq -r '.metadata.name' | tee /dev/stderr)
  [ "${actual}" = "release-name-vault-csi-provider-rolebinding" ]
}