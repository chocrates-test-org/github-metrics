resource "kubernetes_manifest" "letsencrypt_prod_cluster_issuer" {
  depends_on = [
    kubernetes_namespace.insights
  ]
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata   = {
      name      = "letsencrypt-prod"
      namespace = "cert-manager"
    }
    spec = {
      acme = {
        server              = "https://acme-v02.api.letsencrypt.org/directory"
        email               = var.email
        privateKeySecretRef = {
          name = "letsencrypt-prod"
        }
        solvers = [
          {
            selector = {
              dnsZones = var.dns_zones
            }
            dns01 = {
              route53 = {
                region                   = "us-east-1"
                accessKeyID              = var.route53_access_key_id
                secretAccessKeySecretRef = {
                  name = "route53-credentials"
                  key  = "secret-access-key"
                }
              }
            }
          }
        ]
      }
    }
  }
}