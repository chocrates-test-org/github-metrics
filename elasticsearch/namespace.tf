resource "kubernetes_namespace" "insights" {
  metadata {
    name = var.namespace
  }
}