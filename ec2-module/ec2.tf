resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.env}-${var.product}"
  }
}

module "iam" {
    source = "../iam-module"
  }

module "s3" {
    source = "../s3-module"
    
    
}  