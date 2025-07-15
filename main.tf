provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-ssh-key"
  public_key = "YOUR ssh-rsa " #YOUR KEY
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-0a87a69d69fa289be" # Ubuntu 22.04 
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Terraform-Test"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "svist000-my-bucket-test-2025"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.my_bucket.arn]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.my_bucket.arn}/*"]
  }
}

resource "aws_iam_user" "s3_user" {
  name = "s3-access-user"
}

resource "aws_iam_user_policy" "user_policy" {
  name   = "s3-bucket-access"
  user   = aws_iam_user.s3_user.name
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.s3_user.name
}

output "instance_public_ip" {
  value = aws_instance.ubuntu.public_ip
}

output "ssh_command" {
  value = "ssh -i /c/Users/Richard/.ssh/id_rsa ubuntu@${aws_instance.ubuntu.public_ip}" #Where is stored your rsa
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "iam_access_key_id" {
  value     = aws_iam_access_key.user_key.id
  sensitive = true
}

output "iam_secret_access_key" {
  value     = aws_iam_access_key.user_key.secret
  sensitive = true
}
