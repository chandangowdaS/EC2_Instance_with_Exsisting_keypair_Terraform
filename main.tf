resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  description = "Security group for EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "EC2" {
  ami           = "ami-03f65b8614a860c29"
  instance_type = "t2.micro"
  key_name = "morning"
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]

  tags = {
    Name = "EC2_moba"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}

output "instance_IP" {
    value = "aws_instance.EC2.id"
}