output "PROD_BUCKET_NAME" {
  value = "${aws_s3_bucket.web_bootstrap.bucket}"
}
