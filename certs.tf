
data "aws_ssm_parameter" "tls_key" {
  name            = local.tls_key_ssm_path
  with_decryption = true
}

data "aws_ssm_parameter" "tls_crt" {
  name            = local.tls_crt_ssm_path
  with_decryption = true
}

resource "kubernetes_secret" "vault_ca_pair" {
  metadata {
    name      = "vault-ca-pair"
    namespace = local.namespace
  }
  data = {
    "tls.key" = base64decode(data.aws_ssm_parameter.tls_key.value)
    "tls.crt" = base64decode(data.aws_ssm_parameter.tls_crt.value)
  }

  type = "Opaque"

}
