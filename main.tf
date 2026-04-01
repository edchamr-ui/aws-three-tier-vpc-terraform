resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"

    tags = {
        Name = "Public-Subnet-01"
    }
  
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main-IGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}


resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_security_group" "project_sg" {
  name        = "hybrid-project-sg"
  description = "Allow SSH and ICMP for testing"
  vpc_id      = aws_vpc.main.id

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Ping (ICMP) to test connectivity
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Hybrid-Project-SG"
  }
}

resource "aws_instance" "test_server" {
  ami                         = "ami-0440d3b780d96b29d"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.project_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Hybrid-Test-Server"
  }
}
