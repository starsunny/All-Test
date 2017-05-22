/*
Autoscaling
*/

resource "aws_launch_configuration" "test" {
  name          = "terraform"
  image_id      = "ami-80861296"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.allow_all.id}"]
  #enable_monitoring = "disable" 
   
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "asg" {
  availability_zones        = ["us-east-1a","us-east-1b"]
  name                      = "terraform-test"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.test.name}"
  vpc_zone_identifier       = ["${aws_subnet.terrapubsubnet2.id}","${aws_subnet.terrapubsubnet2.id}","${aws_subnet.terrapvtsubnet.id}"]
}


resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
  elb                    = "${aws_elb.terraelb.id}"
}

resource "aws_autoscaling_lifecycle_hook" "aslh" {
  name                   = "test-aslh"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
  default_result         = "CONTINUE"
  heartbeat_timeout      = 2000
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

resource "aws_autoscaling_policy" "bat" {
  name                   = "foobar3-terraform-test"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}


#resource "aws_autoscaling_schedule" "ass" {
 # scheduled_action_name  = "schedule"
  #min_size               = 0
  #max_size               = 1
  #desired_capacity       = 0
  #start_time             = "2017-12-11T18:00:00Z"
  #end_time               = "2017-12-12T06:00:00Z"
  #autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
#}
