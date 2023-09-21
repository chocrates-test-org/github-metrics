resource "kubernetes_ingress" "kibana_ingress" {
  depends_on = [
    kubernetes_namespace.insights,
    kubernetes_manifest.kibana
  ]
  metadata {
    name      = "kibana-ingress"
    namespace = "insights"

    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }

  spec {
    rule {
      host = "kibana.github.expert-services.io"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service_name = "kibana-kb-http"
            service_port = 5601
          }
        }
      }
    }

    tls {
      hosts       = ["kibana.github.expert-services.io"]
      secret_name = "kibana-tls-secret"
    }
  }
}
