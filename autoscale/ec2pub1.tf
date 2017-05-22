/*
create EC2 instance in public subnet 2
*/
resource "aws_instance" "pubec2snd" {
  ami = "ami-80861296"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${aws_subnet.terrapubsubnet2.id}"
  associate_public_ip_address = true
  availability_zone = "us-east-1b"

  tags {
    Name = "terraform ec2 fst"
  }
}

#Elastic Ip asigning
resource "aws_eip" "pubec2snd" {
  instance = "${aws_instance.pubec2snd.id}"
  vpc      = true
  
}
