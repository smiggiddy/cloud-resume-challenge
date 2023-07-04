resource "aws_dynamodb_table" "cloud-resume-table" {
  name         = "Visitors"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "SiteId"

  attribute {
    name = "SiteId"
    type = "S"
  }

}

# resource "aws_dynamodb_table_item" "site" {
#  table_name = aws_dynamodb_table.cloud-resume-table.name
#  hash_key = aws_dynamodb_table.cloud-resume-table.hash_key
#
#  item = <<ITEM
#   {
#   "SiteId": {"S": "resume.mikejr.dev"},
#   "Visits": {"N": "0"}
#   }
#   ITEM
# }


output "cloud-resume-table-id" {
  value = aws_dynamodb_table.cloud-resume-table.id
}

output "cloud-resume-table-arn" {
  value = aws_dynamodb_table.cloud-resume-table.arn
  }
