
# Create Vault Namespace
resource "kubernetes_namespace" "vault" {
  metadata {
    annotations = {
      name = local.name
    }
    labels = {
      istio-injection = "enabled"
    }
    name = local.name
  }
}
