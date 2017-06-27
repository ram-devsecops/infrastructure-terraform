resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.default_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet_01.id}"
  depends_on    = ["aws_internet_gateway.gw"]
}
