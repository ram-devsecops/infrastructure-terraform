# Associate subnet public_subnet_eu_west_1a to public route table
resource "aws_route_table_association"  "public_subnet_ue2a_association_01" {
  subnet_id       = "${aws_subnet.public_subnet_ue2a_01.id}"
  route_table_id  = "${aws_vpc.default.main_route_table_id}"
}

# Associate subnet private_1_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "private_subnet_ue2a_association_01" {
  subnet_id       = "${aws_subnet.private_subnet_ue2a_01.id}"
  route_table_id  = "${aws_route_table.private_route_table.id}"
}

# Associate subnet private_2_subnet_eu_west_1a to private route table
resource "aws_route_table_association" "private_subnet_ue2b_association_01" {
  subnet_id       = "${aws_subnet.private_subnet_ue2b_01.id}"
  route_table_id  = "${aws_route_table.private_route_table.id}"
}
