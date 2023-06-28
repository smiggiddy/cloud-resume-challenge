resource "aws_s3_bucket" "smigtech" {
  bucket = "smigtech"

  tags = {
    Name        = "smigtech"
    Environment = "prod"
  }
}

resource "aws_s3_bucket_website_configuration" "cloud_resume" {
  bucket = aws_s3_bucket.smigtech.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "smigtech_bucket" {
  bucket = aws_s3_bucket.smigtech.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "smigtech_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.smigtech_bucket]
  bucket     = aws_s3_bucket.smigtech.id
  acl        = "private"
}

resource "aws_s3_bucket_versioning" "smigtech_versioning" {
  bucket = aws_s3_bucket.smigtech.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket_policy" "smigtech_policy" {
#   bucket = aws_s3_bucket.smigtech.id
#   policy = data.aws_iam_policy_document.read_smigtech_bucket.json
# }
#
# data "aws_iam_policy_document" "read_smigtech_bucket" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["${aws_s3_bucket.smigtech.arn}/*"]
#
#     principals {
#       type        = "AWS"
#       identifiers = [aws_cloudfront_origin_access_identity.smigtech.iam_arn]
#     }
#   }
#
#   statement {
#     actions   = ["s3:ListBucket"]
#     resources = [aws_s3_bucket.smigtech.arn]
#
#     principals {
#       type        = "AWS"
#       identifiers = [aws_cloudfront_origin_access_identity.smigtech.iam_arn]
#     }
#   }
# }
#
