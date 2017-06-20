# Public subnet
resource "aws_subnet" "public_subnet_ue2a_01" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  tags = {
  	Name = "Public subnet ue2a-01"
  }
}

# Private subnet(s)
resource "aws_subnet" "private_subnet_ue2a_01" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "172.31.2.0/24"
  availability_zone = "us-east-2a"
  tags = {
  	Name =  "Private subnet ue2a-01"
  }
}

resource "aws_subnet" "private_subnet_ue2b_01" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "172.31.3.0/24"
  availability_zone = "us-east-2b"
  tags = {
  	Name =  "Private subnet ue2b-01"
  }
}

# Subnet groups
resource "aws_db_subnet_group" "default" {
  name        = "tf-db-subnet-group"
  description = "The group of default db subnets"
  subnet_ids  = ["${aws_subnet.private_subnet_ue2a_01.id}", "${aws_subnet.private_subnet_ue2b_01.id}"]
  tags = {
  	Name =  "DB subnet group"
  }
}
