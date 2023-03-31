provider "aws" {
  #Norte Virginia
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "my_security_group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_instance_1" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
}

resource "aws_instance" "my_instance_2" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet_2.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
}
