/*
Create ELB
*/
resource "aws_elb" "terraelb" {
  name               = "terraform-elb"
 # availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  subnets = ["${aws_subnet.terrapubsubnet.id}","${aws_subnet.terrapubsubnet2.id}"]
  instances = ["${aws_instance.pubec2fst.id}", "${aws_instance.pubec2snd.id}" ]
  internal = true
 access_logs {
     #bucket        = "elb_logss"
      bucket        = "${aws_s3_bucket.bucketforelblog.id}"
     interval      = 60
   }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  tags {
    Name = "aws-terraform-elb"
  }
}

