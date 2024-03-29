# EC2の作成(1)
resource "aws_instance" "udemy-networking-1-ec2" {
  # UbuntuのAMIを取得
  ami = "ami-07c589821f2b353aa"
  instance_type = "t2.micro"
  availability_zone = "ap-northeast-1a"
  subnet_id = aws_subnet.udemy-networking-1-public1-ap-northeast-1a.id
  vpc_security_group_ids = [aws_security_group.udemy_networking_1_sg.id]
  associate_public_ip_address = "true"

  tags = {
    Name = "udemy-networking-1-ec2"
  }
}

# セキュリティグループの作成(1)
resource "aws_security_group" "udemy_networking_1_sg" {
  name = "udemy-networking-1-sg"
  description = "udemy-networking-1-sg"
  vpc_id = aws_vpc.udemy-networking-1-vpc.id
  tags = {
    Name = "udemy-networking-1-sg"
  }
}

# インバウンドルール(1)
resource "aws_security_group_rule" "udemy_networking_1_ingress" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.udemy_networking_1_sg.id
}

# アウトバウンドルール(1)
resource "aws_security_group_rule" "udemy_networking_1_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.udemy_networking_1_sg.id
}

# インバウンドルールのName(1)
resource "aws_ec2_tag" "udemy_networking_1_ingress_tag" {
  resource_id = aws_security_group_rule.udemy_networking_1_ingress.security_group_rule_id
  key = "Name"
  value = "udemy-networking-1-ingress"
}

# アウトバウンドルールのName(1)
resource "aws_ec2_tag" "udemy_networking_1_engress_tag" {
  resource_id = aws_security_group_rule.udemy_networking_1_egress.security_group_rule_id
  key = "Name"
  value = "udemy-networking-1-engress"
}

# EC2の作成(2)
resource "aws_instance" "udemy-networking-2-ec2" {
  # UbuntuのAMIを取得
  ami = "ami-07c589821f2b353aa"
  instance_type = "t2.micro"
  availability_zone = "ap-northeast-1a"
  subnet_id = aws_subnet.udemy-networking-2-public1-ap-northeast-1a.id
  vpc_security_group_ids = [aws_security_group.udemy_networking_2_sg.id]
  associate_public_ip_address = "true"

  # nginxのインストール
  user_data = <<EOF
    #!/bin/bash
    sudo apt update -y && sudo apt install -y nginx
  EOF

  tags = {
    Name = "udemy-networking-2-ec2"
  }
}

# セキュリティグループの作成(2)
resource "aws_security_group" "udemy_networking_2_sg" {
  name = "udemy-networking-2-sg"
  description = "udemy-networking-2-sg"
  vpc_id = aws_vpc.udemy-networking-2-vpc.id
  tags = {
    Name = "udemy-networking-2-sg"
  }
}

# インバウンドルール(2) http
resource "aws_security_group_rule" "udemy_networking_2_ingress" {
  type = "ingress"
  description = "for HTTP"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.udemy_networking_2_sg.id
}

# インバウンドルール(2) ssh
resource "aws_security_group_rule" "udemy_networking_2_ssh_ingress" {
  type = "ingress"
  description = "for SSH"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.udemy_networking_2_sg.id
}

# アウトバウンドルール(2)
resource "aws_security_group_rule" "udemy_networking_2_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.udemy_networking_2_sg.id
}

# インバウンドルールのName(2)
resource "aws_ec2_tag" "udemy_networking_2_ingress_tag" {
  resource_id = aws_security_group_rule.udemy_networking_2_ingress.security_group_rule_id
  key = "Name"
  value = "udemy-networking-2-ingress"
}

# インバウンドルールのName(2)
resource "aws_ec2_tag" "udemy_networking_2_ssh_ingress_tag" {
  resource_id = aws_security_group_rule.udemy_networking_2_ssh_ingress.security_group_rule_id
  key = "Name"
  value = "udemy_networking_2_ssh_ingress"
}

# アウトバウンドルールのName(2)
resource "aws_ec2_tag" "udemy_networking_2_engress_tag" {
  resource_id = aws_security_group_rule.udemy_networking_2_egress.security_group_rule_id
  key = "Name"
  value = "udemy-networking-2-engress"
}

# EC2の作成(3)
resource "aws_instance" "udemy-networking-1-ec2-private" {
  # UbuntuのAMIを取得
  ami = "ami-07c589821f2b353aa"
  instance_type = "t2.micro"
  availability_zone = "ap-northeast-1a"
  subnet_id = aws_subnet.udemy-networking-1-private1-ap-northeast-1a.id
  # 既存のセキュリティグループ
  vpc_security_group_ids = [aws_security_group.udemy_networking_1_sg.id]
  # TODO: ここもterraform化すること
  key_name = "udemy-networking-key"

  tags = {
    Name = "udemy-networking-1-ec2-private"
  }
}
