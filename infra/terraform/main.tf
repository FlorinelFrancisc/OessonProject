resource "aws_vpc" "devops_vpc" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "devops-vpc" }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
  tags                    = { Name = "subnet-a" }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true
  tags                    = { Name = "subnet-b" }
}

# Security group for SSH, HTTP, NodePort
resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH, HTTP, NodePort"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30000
    to_port     = 32767
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

# EC2 for Jenkins
resource "aws_instance" "jenkins_host" {
  ami                    = "ami-077d5785555aeb549" # Amazon Linux 2 (update as needed)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags                   = { Name = "jenkins-host" }
}

# EC2 for K8s nodes
resource "aws_instance" "k8s_node_a" {
  ami                    = "ami-077d5785555aeb549"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags                   = { Name = "k8s-node-a" }
}

resource "aws_instance" "k8s_node_b" {
  ami                    = "ami-077d5785555aeb549"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet_b.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags                   = { Name = "k8s-node-b" }
}
