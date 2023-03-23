resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.env}-${var.product}-s3-bucket"

  tags = {
    Name        = var.name
    Environment = var.env
  }
}