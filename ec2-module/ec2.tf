resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.env}-${var.product}"
  }
}

module "iam" {
    source = "../iam-module"
    env = var.env
    product = var.product
}

module "s3" {
    source = "../s3-module"
    env = var.env
    product = var.product
    name = var.name
}  