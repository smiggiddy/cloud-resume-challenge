resource "aws_s3_bucket" "smigtech" {
  bucket = "smigtech_bucket"

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
