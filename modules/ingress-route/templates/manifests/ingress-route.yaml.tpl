apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
%{ if length(metadata.annotations) > 0 ~}
  annotations:
    ${indent(4, yamlencode(metadata.annotations))}
%{ endif ~}
  name: ${metadata.name}
  namespace: ${metadata.namespace}
spec:
  entryPoints:
    ${indent(4, yamlencode(spec.entry_points))}
%{ if length(spec.routes) > 0 ~}
  routes:
%{ for route in spec.routes ~}
    - kind: Rule
      match: Host(${join(",", formatlist("`%s`", route.match.hosts))}) && PathPrefix(${join(",", formatlist("`%s`", route.match.pathPrefix))})
      services:
        - name: ${route.service.name}
          port: ${route.service.port}
%{ endfor ~}
%{~ endif }
  tls:
    certResolver: ${spec.tls.cert_resolver}