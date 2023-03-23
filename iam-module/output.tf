output "role_arn" {
    value = aws_iam_role.iam_role.arn
}

output "role_name" {
    value = aws_iam_role.iam_role.name
  
}

output "ec2-profile" {
    value = aws_iam_instance_profile.ec2_profile.id
}