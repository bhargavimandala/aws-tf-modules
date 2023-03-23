resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  iam_instance_profile = module.iam.ec2-profile
  vpc_security_group_ids = [module.sg.sg_id]

  tags = {
    Name = "${var.env}-${var.product}"
  }
}

module "iam" {
    source = "../iam-module"
    env = var.env
    product = var.product
    policy_name = "s3-policy"
}

module "s3" {
    source = "../s3-module"
    env = var.env
    product = var.product
    
}  

module "sg" {
  source = "../sg-module"
  env = var.env
  product = var.product
  vpc_id = "vpc-003aa9bde553f8665"
}
