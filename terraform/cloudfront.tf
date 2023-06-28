locals {
  s3_origin_id = "smigtechBucketOrigin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.smigtech.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id = local.s3_origin_id
   }

   enabled = true
   is_ipv6_enabled = true
   comment = "SmigTech resume CDN enabled"
   default_root_object = "index.html"

   aliases = ["resume.mikejr.dev"]

}
