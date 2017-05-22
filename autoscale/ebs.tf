/*
create ebs volume
*/
resource "aws_ebs_volume" "ebsfst" {
    availability_zone = "us-east-1c"
    size = 4
    tags {
        Name = "ebs for first ec2 "
    }
}

/*
attatch volume to ec2 instance
*/
resource "aws_volume_attachment" "ebs_atttoec2fst" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ebsfst.id}"
  instance_id = "${aws_instance.pubec2fst.id}"
}

/*
create ebs volume
*/
resource "aws_ebs_volume" "ebs2nd" {
    availability_zone = "us-east-1b"
    size = 4
    tags {
        Name = "ebs for second ec2 "
    }
}

/*
attatch volume to 2nd ec2 instance
*/
resource "aws_volume_attachment" "ebs_atttoec2snd" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ebs2nd.id}"
  instance_id = "${aws_instance.pubec2snd.id}"
}
