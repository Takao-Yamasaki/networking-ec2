# VPCを作成(1)
resource "aws_vpc" "udemy-networking-1-vpc" {
  cidr_block = "10.0.0.0/16"
  # DNSによる名前解決をサポート
  enable_dns_support = true
  # DNSホスト名を有効化
  enable_dns_hostnames = true
  tags = {
    Name = "udemy-networking-1-vpc"
  }
}

# パブリックサブネット(1)
resource "aws_subnet" "udemy-networking-1-public1-ap-northeast-1a" {
  vpc_id = aws_vpc.udemy-networking-1-vpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "ap-northeast-1a"
  #パブリックIPアドレスの自動割り当て
  map_public_ip_on_launch = true
  
  tags = {
    Name = "udemy-networking-1-public1-ap-northeast-1a"
  }
}

# インターネットゲートウェイの作成(1)
resource "aws_internet_gateway" "udemy-networking-1-igw" {
  vpc_id = aws_vpc.udemy-networking-1-vpc.id
  
  tags = {
    Name = "udemy-networking-1-igw"
  }
}

# ルートテーブルの作成(1)
resource "aws_route_table" "udemy-networking-1-rt" {
  vpc_id = aws_vpc.udemy-networking-1-vpc.id
  
  tags = {
    Name = "udemy-networking-1-rt"
  }
}

# エントリの追加(1)
resource "aws_route" "udemy-networking-1-rt-public" {
  route_table_id = aws_route_table.udemy-networking-1-rt.id
  gateway_id = aws_internet_gateway.udemy-networking-1-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# サブネットとルートテーブルの関連付け(1)
resource "aws_route_table_association" "udemy-networking-1-rt-associate" {
  subnet_id = aws_subnet.udemy-networking-1-public1-ap-northeast-1a.id
  route_table_id = aws_route_table.udemy-networking-1-rt.id
}

# VPCを作成(2)
resource "aws_vpc" "udemy-networking-2-vpc" {
  cidr_block = "172.16.0.0/16"
  # DNSによる名前解決をサポート
  enable_dns_support = true
  # DNSホスト名を有効化
  enable_dns_hostnames = true
  tags = {
    Name = "udemy-networking-2-vpc"
  }
}

# パブリックサブネット(2)
resource "aws_subnet" "udemy-networking-2-public1-ap-northeast-1a" {
  vpc_id = aws_vpc.udemy-networking-2-vpc.id
  cidr_block = "172.16.0.0/20"
  availability_zone = "ap-northeast-1a"
  #パブリックIPアドレスの自動割り当て
  map_public_ip_on_launch = true
  
  tags = {
    Name = "udemy-networking-2-public1-ap-northeast-1a"
  }
}

# インターネットゲートウェイの作成(2)
resource "aws_internet_gateway" "udemy-networking-2-igw" {
  vpc_id = aws_vpc.udemy-networking-2-vpc.id
  
  tags = {
    Name = "udemy-networking-2-igw"
  }
}

# ルートテーブルの作成(2)
resource "aws_route_table" "udemy-networking-2-rt" {
  vpc_id = aws_vpc.udemy-networking-2-vpc.id
  
  tags = {
    Name = "udemy-networking-2-rt"
  }
}

# エントリの追加(2)
resource "aws_route" "udemy-networking-2-rt-public" {
  route_table_id = aws_route_table.udemy-networking-2-rt.id
  gateway_id = aws_internet_gateway.udemy-networking-2-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# サブネットとルートテーブルの関連付け(2)
resource "aws_route_table_association" "udemy-networking-2-rt-associate" {
  subnet_id = aws_subnet.udemy-networking-2-public1-ap-northeast-1a.id
  route_table_id = aws_route_table.udemy-networking-2-rt.id
}
