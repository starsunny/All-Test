/*
create vpc
*/
resource "aws_vpc" "terravpc" {
  cidr_block = "${var.vpc_cidr}"
   enable_dns_hostnames = true
  tags {
   Name = "terraform vpc"
  }
}

/*
create and attatch IGW to terraform vpc
*/

resource "aws_internet_gateway" "terraigw" {
  vpc_id = "${aws_vpc.terravpc.id}"

  tags {
    Name = "terraform IGW"
  }
}

/*
create public subnet
*/
resource "aws_subnet" "terrapubsubnet" {
  vpc_id     = "${aws_vpc.terravpc.id}"
  cidr_block = "${var.pub_subnet_cidr}"
  availability_zone = "us-east-1c"
  tags {
    Name = "terraform public subnet"
  }
}

/*
create public subnet2
*/
resource "aws_subnet" "terrapubsubnet2" {
  vpc_id     = "${aws_vpc.terravpc.id}"
  cidr_block = "${var.pub2_subnet_cidr}"
  availability_zone = "us-east-1b"
  tags {
    Name = "terraform public2 subnet"
  }
}

/*
create routing table for public subnet
*/
resource "aws_route_table" "route_pub" {
  vpc_id = "${aws_vpc.terravpc.id}"

  route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.terraigw.id}"
  }

  tags {
    Name = "public route"
  }
}

/*
associate subnets with public routing table
*/
resource "aws_route_table_association" "pub" {
  subnet_id = "${aws_subnet.terrapubsubnet.id}"
  route_table_id = "${aws_route_table.route_pub.id}"
}
resource "aws_route_table_association" "pub2" {
  subnet_id = "${aws_subnet.terrapubsubnet2.id}"
  route_table_id = "${aws_route_table.route_pub.id}"
}

/*
create private subnet
*/
resource "aws_subnet" "terrapvtsubnet" {
  vpc_id     = "${aws_vpc.terravpc.id}"
  cidr_block = "${var.pvt_subnet_cidr}"
  availability_zone = "us-east-1a"
  tags {
    Name = "terraform private subnet"
  }
}

/*
routing table for private subnet
*/
resource "aws_route_table" "route_pvt" {
  vpc_id = "${aws_vpc.terravpc.id}"

   tags {
    Name = "private route"
  }
}

/*
associate subnets with private routing table
*/

resource "aws_route_table_association" "pvt" {
  subnet_id      = "${aws_subnet.terrapvtsubnet.id}"
  route_table_id = "${aws_route_table.route_pvt.id}"
}
