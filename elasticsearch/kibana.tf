resource "kubernetes_manifest" "kibana" {
  depends_on = [
    kubernetes_namespace.insights,
    kubernetes_manifest.elasticsearch
  ]
  manifest = {
    apiVersion = "kibana.k8s.elastic.co/v1"
    kind       = "Kibana"
    metadata   = {
      name      = "kibana"
      namespace = "insights"
    }
    spec = {
      version          = "8.9.0"
      count            = 1
      elasticsearchRef = {
        name = "elasticsearch"
      }
      config = {
        "server.publicBaseUrl" = var.kibana_base_url
      }
      http = {
        service = {
          spec = {
            type = "ClusterIP"
          }
        }
        tls = {
          selfSignedCertificate = {
            disabled = true
          }
        }
      }
      podTemplate = {
        metadata = {
          labels = {
            app = "kibana"
          }
        }
        spec = {
          containers = [
            {
              name      = "kibana"
              resources = {
                requests = {
                  memory = "1Gi"
                  cpu    = 0.5
                }
                limits = {
                  memory = "2Gi"
                  cpu    = 2
                }
              }
            }
          ]
        }
      }
    }
  }
}