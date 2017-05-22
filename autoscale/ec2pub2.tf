/*
create EC2 instance in public subnet 1
*/
resource "aws_instance" "pubec2fst" {
  ami = "ami-80861296"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${aws_subnet.terrapubsubnet.id}"
  associate_public_ip_address = true
  availability_zone = "us-east-1c"
  security_groups    = ["${aws_security_group.allow_all.id}"]
  

  tags {
    Name = "terraform ec2 fst"
  }
}


#Elastic IP allocation
resource "aws_eip" "pubec2fst" {
  instance = "${aws_instance.pubec2fst.id}"
  vpc      = true
  
}
