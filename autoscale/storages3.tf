/*
Create s3 bucket
*/
resource "aws_s3_bucket" "bucket" {
  bucket = "Pukhu"
  acl    = "private"
}


#Create s3 bucket for elb logs
resource "aws_s3_bucket" "bucketforelblog" {
  bucket = "elb_logss"
   acl    = "public-read-write"

}
