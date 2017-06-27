# Public subnet
resource "aws_subnets" "public_subnet_01" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"
  tags = {
  	Name = "Public subnet ue2a-01"
  }
}

# Private subnet(s)
# resource "aws_subnet" "private_subnet_01" {
#   vpc_id            = "${aws_vpc.default.id}"
#   cidr_block        = "172.31.2.0/24"
#   availability_zone = "${var.aws_region}a"
#   tags = {
#   	Name =  "Private subnet ${var.aws_region_abbr}a"
#   }
# }
#
# resource "aws_subnet" "private_subnet_02" {
#   count             = 2
#   vpc_id            = "${aws_vpc.default.id}"
#   cidr_block        = "172.31.3.0/24"
#   availability_zone = "${var.aws_region}b"
#   tags = {
#   	Name =  "Private subnet ${var.aws_region_abbr}b"
#   }
# }

resource "aws_subnets" "private" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${module.variables.private_subnets[count.index]}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(module.variables.private_subnets)}"
  tags              = "${merge(var.tags, var.private_subnet_tags, map("Name", format("%s-subnet-private-%s", var.name, element(var.availability_zones, count.index))))}"
}

# Subnet groups
resource "aws_db_subnet_group" "default" {
  name        = "tf-db-subnet-group"
  description = "The group of default db subnets"
  subnet_ids  = ["${aws_subnets.database.*.id}"]
  tags = {
  	Name =  "DB subnet group"
  }
}
