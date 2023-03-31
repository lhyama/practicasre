provider "aws" {
  region = "us-east-1" # AWS región
}

resource "aws_vpc" "practica" {
  cidr_block = "10.0.0.0/16" # CIDR

  tags = {
    Name = "practicaVPC"
  }
}

resource "aws_subnet" "practica" {
  cidr_block = "10.0.1.0/24" # CIDR
  vpc_id     = aws_vpc.practica.id

  tags = {
    Name = "practicaSubnet"
  }
}

resource "aws_security_group" "practica" {
  name_prefix = "practicaSG-"

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

resource "aws_instance" "practica" {
  ami           = "ami-007855ac798b5175e" # AMI
  instance_type = "t2.micro" # tipo de instancia
  count         = 2 # Crear dos instancias

  subnet_id              = aws_subnet.practica.id
  vpc_security_group_ids = [aws_security_group.practica.id]

  tags = {
    Name = "practicaInstance-${count.index+1}"
  }
}
