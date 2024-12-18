/**
 * Copyright (C) 2023-2024 Solution Libre <contact@solution-libre.fr>
 * 
 * This file is part of Traefik Terraform module.
 * 
 * Traefik Terraform module is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Traefik Terraform module is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Traefik Terraform module.  If not, see <https://www.gnu.org/licenses/>.
 */

module "ingress_routes_tcp" {
  source = "./modules/ingress-route-tcp"

  for_each = var.ingress_routes_tcp

  metadata = merge(
    { name = each.key },
    each.value.metadata
  )

  spec = {
    entry_points = [each.value.entry_point.name]
    routes = {
      service     = each.value.service
      middlewares = each.value.middlewares
    }

    tls = each.value.tls
  }

  depends_on = [
    module.generic
  ]
}
