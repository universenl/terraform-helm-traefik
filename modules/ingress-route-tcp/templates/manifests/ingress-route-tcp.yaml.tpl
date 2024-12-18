apiVersion: traefik.io/v1alpha1
kind: IngressRouteTCP
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
  routes:
  - match: HostSNI(`*`)
    services:
    - name: ${spec.routes.service.name}
      port: ${spec.routes.service.port}
%{ if try(spec.routes.service.proxy_protocol.enabled, false) ~}
      proxyProtocol:
        version: ${spec.routes.service.proxy_protocol.version}
%{ endif ~}
%{ if length(spec.routes.middlewares) > 0 ~}
    middlewares:
%{ for middleware in spec.routes.middlewares ~}
    - name: ${middleware}
%{ endfor ~}
%{ endif ~}
%{ if try(spec.tls.enabled, false) ~}
  tls:
    certResolver: ${spec.tls.cert_resolver}
%{ endif ~}
