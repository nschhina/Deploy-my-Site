locals {
  website_bucket_name = "${local.project_name}-${terraform.workspace}-website"
}

resource "aws_s3_bucket" "websitedeployment" {
  bucket = "${local.website_bucket_name}"
  acl    = "public-read"
  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"PublicReadGetObject",
        "Effect":"Allow",
        "Principal": "*",
        "Action":["s3:GetObject"],
        "Resource":["arn:aws:s3:::${local.website_bucket_name}/*"]
      }
    ]
}
POLICY

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags {
    Environment = "${terraform.workspace}"
  }
}


locals {
  site_root = "../website/static"
  index_html = "${local.site_root}/index.html"
  main_css = "${local.site_root}/style.css"
}

resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.websitedeployment.id}"
  key    = "index.html"
  source = "${local.index_html}"
  etag   = "${md5(file(local.index_html))}"
  content_type = "text/html"
}


resource "aws_s3_bucket_object" "css" {
  bucket = "${aws_s3_bucket.websitedeployment.id}"
  key    = "style.css"
  source = "${local.main_css}"
  etag   = "${md5(file(local.main_css))}"
  content_type = "text/css"
}

output "url" {
  value = "http://${local.website_bucket_name}.s3-website.${aws_s3_bucket.websitedeployment.region}.amazonaws.com"
}
