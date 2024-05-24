resource "aws_vpc" "dev_vpc" {
  cidr_block = "172.31.0.0/16"

  tags = {
    Name = "DEV-VPC"
  }
}

resource "aws_subnet" "dev_public_subnet_az1" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "Dev-Public-Subnet1"
  }
}


resource "aws_subnet" "dev_public_subnet_az2" {
    vpc_id = aws_vpc.dev_vpc.id
    cidr_block = "172.31.2.0/24"
    availability_zone = "ap-southeast-1b"

    tags = {
        Name = "Dev-Public-Subnet2"
    }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "Dev-Internet-Gateway"
  }
}

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.dev_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev_igw.id
    }

    tags = {
        Name = "Dev-Public-RTB"
    }
}

resource "aws_route_table_association" "dev_ac_public_az1" {
    subnet_id      = aws_subnet.dev_public_subnet_az1.id
    route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "dev_ac_public_az2" {
    subnet_id      = aws_subnet.dev_public_subnet_az2.id
    route_table_id = aws_route_table.public_rtb.id
}


resource "aws_security_group" "dev_public_sg" {
  name        = "Dev-Public-SG"
  vpc_id      = aws_vpc.dev_vpc.id
  tags        = { Name = "Dev-Public-SG" }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # All IPv4 addresses
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "dev_frontend_sg" {
  name        = "Dev-Frontend-SG"
  vpc_id      = aws_vpc.dev_vpc.id
  tags        = { Name = "Dev-Frontend-SG" }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # All IPv4 addresses
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "dev_backend_sg" {
  name        = "Dev-Backend-SG"
  vpc_id      = aws_vpc.dev_vpc.id
  tags        = { Name = "Dev-Backend-SG" }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
