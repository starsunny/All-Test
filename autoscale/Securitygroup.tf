/*
Creating Security group
*/
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  vpc_id      = "${aws_vpc.terravpc.id}"
  description = "Allow all inbound traffic"
  
} 
  
resource "aws_security_group_rule" "all_inbound" {
    type = "ingress"

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.allow_all.id}"
}

resource "aws_security_group_rule" "allow_db_access" {
    type = "ingress"

    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.allow_all.id}"
}



