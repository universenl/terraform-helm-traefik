apiVersion: traefik.io/v1alpha1
kind: MiddlewareTCP
metadata:
  ${indent(2, yamlencode(metadata))}
spec:
  ${indent(2, yamlencode(spec))}
