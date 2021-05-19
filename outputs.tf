output "vault_namespace" { value = kubernetes_namespace.vault.id }
output "vault_iam_role" { value = aws_iam_role.vault.arn }
