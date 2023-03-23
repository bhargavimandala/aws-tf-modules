resource "aws_iam_role" "iam_role" {
  name = "${var.env}-${var.product}-iam-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    environment = var.env
    product = var.product
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.product}.${var.env}.ec2-profile"
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_policy" "s3_policy" {
  name        = var.policy_name
  
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::dev-ford-s3-bucket"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

