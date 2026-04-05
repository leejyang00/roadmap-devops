
# query for AMIs
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}

# EC2 instance to SSH into
resource "aws_instance" "main" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.main_instance_sg.id]
  key_name               = var.key_name

  instance_market_options {
    market_type = "spot"

    spot_options {
      max_price = "0.03"
    }
  }

  tags = {
    Name = var.instance_name
  }
}

# Security Group for the main EC2 instance
resource "aws_security_group" "main_instance_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for ${var.instance_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.instance_name}-sg-tag"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.main_instance_sg.id

  cidr_ipv4   = "101.115.169.163/32" # "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.main_instance_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "-1"
  to_port     = -1
}

