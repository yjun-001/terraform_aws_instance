provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_security_group" "allow_ssh_sg"  {
  name = "allow_ssh"
  description = "allow ssh inbond traffic"

  ingress {
    from_port = 22
    to_port =22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
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

  key_name = "aws_hpc_keypair"
  security_groups = ["${aws_security_group.allow_ssh_sg.name}"]
}

output "aws_hpc_instance" {
    #value = aws_instance.aws_hpc_instance.public_dns
    value = aws_instance.aws_hpc_instance.public_ip
}

