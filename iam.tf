resource "aws_iam_role_policy" "vault_kms" {
  name   = local.iam_role_policy_kms
  role = aws_iam_role.vault.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "kms:Decrypt",
            "kms:Encrypt",
            "kms:DescribeKey"
          ],
          "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "vault_iam" {
  name   = local.iam_role_policy_iam
  role   = aws_iam_role.vault.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": [
                "arn:aws:iam::${local.account}:role/${local.k8s_role}"
            ]
        }
    ]
}
EOF
}
