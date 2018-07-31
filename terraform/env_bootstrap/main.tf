locals {
  state_bucket_name = "${local.project_name}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}

resource "aws_s3_bucket" "backend_bootstrap" {
  bucket = "${local.state_bucket_name}"
  region = "${data.aws_region.current.name}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    "rule" {
      "apply_server_side_encryption_by_default" {
        sse_algorithm = "AES256"
      }
    }
  }

  tags {
    Name = "terraform-state-bucket"
    Environment = "global"
    project = "${local.project_name}"
  }
}
