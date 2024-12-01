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
          match: Host(${join(",", formatlist("`%s`", route.match.hosts))})


%{~ if length(spec.routes.match.paths) > 0 || length(spec.routes.match.path_prefixes) > 0 ~}
 &&
%{~ if length(spec.routes.match.paths) > 0 && length(spec.routes.match.path_prefixes) > 0 ~}
 (
%{~ endif}
%{~ if length(spec.routes.match.paths) > 0 ~}
 Path(${join(",", formatlist("`%s`", spec.routes.match.paths))})
%{~ endif ~}
%{~ if length(spec.routes.match.paths) > 0 && length(spec.routes.match.path_prefixes) > 0 ~}
 ||
%{~ endif ~}
%{~ if length(spec.routes.match.path_prefixes) > 0 ~}
 PathPrefix(${join(",", formatlist("`%s`", spec.routes.match.path_prefixes))})
%{~ endif ~}
%{~ if length(spec.routes.match.paths) > 0 && length(spec.routes.match.path_prefixes) > 0 ~}
 )
%{~ endif }
%{~ endif }


%{ endfor ~}
%{~ endif }

  tls:
    certResolver: ${spec.tls.cert_resolver}
