apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  ${indent(2, yamlencode(metadata))}
spec:
  ${indent(2, yamlencode(spec))}
