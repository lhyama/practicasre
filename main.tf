provider "aws" {
  region = "us-east-1" # Cambiar a la región de tu preferencia
}

resource "aws_vpc" "practica" {
  cidr_block = "10.0.0.0/16" # Cambiar a la CIDR de tu preferencia

  tags = {
    Name = "practicaVPC"
  }
}

resource "aws_subnet" "practica" {
  cidr_block = "10.0.1.0/24" # Cambiar a la CIDR de tu preferencia
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
  ami           = "ami-0c55b159cbfafe1f0" # Cambiar a la AMI de tu preferencia
  instance_type = "t2.micro" # Cambiar al tipo de instancia de tu preferencia
  count         = 2 # Crear dos instancias

  subnet_id              = aws_subnet.practica.id
  vpc_security_group_ids = [aws_security_group.practica.id]

  tags = {
    Name = "practicaInstance-${count.index+1}"
  }
}
