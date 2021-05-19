
# Get Data for the kms key
data "aws_kms_key" "vault" {
  key_id = "alias/${local.kms_key_alias}"
}

# Data resource to pull in Cert issuer manifest
data "kubectl_file_documents" "cert_issuer" {
  content = file("./manifests/certs.yaml")
}
# Install Cert Issuer for Vault Namespace
resource "kubectl_manifest" "cert_issuer" {
  count     = length(data.kubectl_file_documents.cert_issuer.documents)
  yaml_body = element(data.kubectl_file_documents.cert_issuer.documents, count.index)
}

# Data resource to pull in Ingress gateway manifest
data "kubectl_file_documents" "ingress" {
  content = file("./manifests/ingress.yaml")
}
# Install Vault Secure Ingress Gateway
resource "kubectl_manifest" "ingress" {
  count     = length(data.kubectl_file_documents.ingress.documents)
  yaml_body = element(data.kubectl_file_documents.ingress.documents, count.index)
}


resource "helm_release" "vault" {
  name          = local.name
  chart         = local.helm_chart
  repository    = local.helm_repository
  version       = local.helm_chart_version
  namespace     = local.name
  recreate_pods = false
  reuse_values  = true
  values = [templatefile("./manifests/override-values.yaml", {
    helm_app_version  = local.helm_app_version,
    vault_unseal_key  = data.aws_kms_key.vault.id
    vault_skip_verify = local.vault_skip_verify
    helm_extra_values = {
      AWS_REGION                  = local.region
      VAULT_SKIP_VERIFY           = local.vault_skip_verify
      AWS_ROLE_ARN                = aws_iam_role.vault.arn
    }
    ha_sa = { "eks.amazonaws.com/role-arn" = aws_iam_role.vault.arn }
  })]
}
