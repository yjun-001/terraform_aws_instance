provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "aws_hpc_instance" {
  ami           = "ami-0d5bf08bc8017c83b"
  instance_type = "t2.micro"

  tags = {
    Name = "HPC aws instance"
    Environment = "Sandbox"
    OS = "Ubuntu 20.04"
    Managed = "IaC"
  }
}

output "aws_hpc_instance" {
    value = aws_instance.aws_hpc_instance.public_ip
}

