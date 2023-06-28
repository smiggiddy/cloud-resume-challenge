locals {
  s3_origin_id = aws_s3_bucket.smigtech.id
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.smigtech.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "SmigTech resume CDN enabled"
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }
  price_class = "PriceClass_100"

  aliases = ["resume.mikejr.dev"]

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = "arn:aws:acm:us-east-1:585215851943:certificate/c9177df5-7669-430e-9da1-b0f82642cc03"
    ssl_support_method             = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "smigtechBucketAccessControl"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
