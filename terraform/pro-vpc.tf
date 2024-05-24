resource "aws_vpc" "ecs_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ECS-VPC"
  }
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "Public-Subnet1"
  }
}


resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "Public-Subnet2"
  }
}


resource "aws_subnet" "private_subnet_az1" {
    vpc_id = aws_vpc.ecs_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-southeast-1a"

    tags = {
        Name = "Private-Subnet1"
    }
}

resource "aws_subnet" "private_subnet_az2" {
    vpc_id = aws_vpc.ecs_vpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-southeast-1b"

    tags = {
        Name = "Private-Subnet2"
    }
}

resource "aws_internet_gateway" "ecs_igw" {
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    Name = "ECS-Internet-Gateway"
  }
}

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.ecs_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ecs_igw.id
    }

    tags = {
        Name = "Public-RTB"
    }
}

resource "aws_eip" "nat_gateway1" {
  domain = "vpc"
  # depends_on = [aws_internet_gateway.ecs_igw]
}

resource "aws_eip" "nat_gateway2" {
  domain = "vpc"
  # depends_on = [aws_internet_gateway.ecs_igw]
}

resource "aws_nat_gateway" "nat_gw_az1" {
    allocation_id = aws_eip.nat_gateway1.id
    subnet_id     = aws_subnet.public_subnet_az1.id

    tags = {
        Name = "NAT-az1"
    }

    depends_on = [aws_internet_gateway.ecs_igw]
}

resource "aws_nat_gateway" "nat_gw_az2" {
    allocation_id = aws_eip.nat_gateway2.id
    subnet_id     = aws_subnet.public_subnet_az1.id

    tags = {
        Name = "NAT-az2"
    }

    depends_on = [aws_internet_gateway.ecs_igw]
}


resource "aws_route_table" "private1_rtb" {
    vpc_id = aws_vpc.ecs_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
    }

    tags = {
        Name = "Private1-RTB"
    }
}

resource "aws_route_table" "private2_rtb" {
    vpc_id = aws_vpc.ecs_vpc.id

     route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw_az2.id
    }

    tags = {
        Name = "Private2-RTB"
    }
}

resource "aws_route_table_association" "ac_public_az1" {
    subnet_id      = aws_subnet.public_subnet_az1.id
    route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "ac_public_az2" {
    subnet_id      = aws_subnet.public_subnet_az2.id
    route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "ac_private_az1" {
    subnet_id      = aws_subnet.private_subnet_az1.id
    route_table_id = aws_route_table.private1_rtb.id
}

resource "aws_route_table_association" "ac_private_az2" {
    subnet_id      = aws_subnet.private_subnet_az2.id
    route_table_id = aws_route_table.private2_rtb.id
}


resource "aws_security_group" "public_sg" {
  name        = "Public-SG"
  vpc_id      = aws_vpc.ecs_vpc.id
  tags        = { Name = "Public-SG" }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # All IPv4 addresses
  }

  ingress {
    from_port   = 5173
    to_port     = 5173
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # All IPv4 addresses
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

resource "aws_security_group" "frontend_sg" {
  name        = "Frontend-SG"
  vpc_id      = aws_vpc.ecs_vpc.id
  tags        = { Name = "Frontend-SG" }

  ingress {
    from_port   = 5173
    to_port     = 5173
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

resource "aws_security_group" "backend_sg" {
  name        = "Backend-SG"
  vpc_id      = aws_vpc.ecs_vpc.id
  tags        = { Name = "Backend-SG" }

  ingress {
    from_port   = 5000
    to_port     = 5000
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
