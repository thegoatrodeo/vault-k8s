locals {
  name           = "vault"
  namespace      = "vault"
  environment    = "production"
  region         = data.terraform_remote_state.vpc.outputs.region
  config_path    = "~/.kube/config"
  config_context = "kubernetes_cluster_name"
  # IAM Configuration
  iam_role = "${local.environment}-${local.name}-iam-svc-account"
  # Secrets path inside the kubernetes pod to look for the service account token
  iam_identity_token_path = "/var/run/secrets/eks.amazonaws.com/serviceaccount/token"
  aws_account             = "" # AWS Account ID
  k8s_role                = "" # Kubernetes Role that created the cluster. Used in iam.tf

  # Vault Settings:
  vault_skip_verify = true
  # Helm Settings
  # Latest App Version: $(helm search repo hashicorp/vault -l )
  helm_chart         = local.name
  helm_chart_version = "0.11.0"
  helm_repository    = "https://helm.releases.hashicorp.com"
  helm_app_version   = "1.7.0"

  # Certificate Configuration
  tls_crt_ssm_path = "/${local.environment}/tls/${local.name}/tls.crt"
  tls_key_ssm_path = "/${local.environment}/tls/${local.name}/tls.key"

  # KMS Key Config
  kms_key_alias       = "${local.environment}-vault-kms-unseal-key"
  iam_role_policy_kms = "${local.environment}-${local.name}-kms-policy"
  iam_role_policy_iam = "${local.environment}-${local.name}-iam-policy"


}
