resource "aws_instance" "udemy-networking-ec2" {
  # UbuntuのAMIを取得
  ami = "ami-07c589821f2b353aa"
  instance_type = "t2.micro"
  availability_zone = "ap-northeast-1a"
  vpc_security_group_ids = [aws_security_group.udemy_networking_sg.id]
  associate_public_ip_address = "true"

  tags = {
    Name = "udemy-networking-ec2"
  }
}

# デフォルトのVPCを取得
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# セキュリティグループの作成
resource "aws_security_group" "udemy_networking_sg" {
  name = "udemy_networking_sg"
  vpc_id = aws_default_vpc.default.id
  tags = {
    Name = "udemy_networking_sg"
  }
}

# インバウンドルール
resource "aws_security_group_rule" "udemy_networking_ingress" {
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.udemy_networking_sg.id
}

# アウトバウンドルール
resource "aws_security_group_rule" "udemy_networking_egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.udemy_networking_sg.id
}

# Name
resource "aws_ec2_tag" "udemy_networking_ingress_tag" {
  resource_id = aws_security_group_rule.udemy_networking_ingress.security_group_rule_id
  key = "Name"
  value = "udemy_networking_ingress"
}

# Name
resource "aws_ec2_tag" "udemy_networking_engress_tag" {
  resource_id = aws_security_group_rule.udemy_networking_egress.security_group_rule_id
  key = "Name"
  value = "udemy_networking_engress"
}
