module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"
  name                        = "xray-demo-table1"
  hash_key                    = "id"
  range_key                   = "value"
  table_class                 = "STANDARD"
  deletion_protection_enabled = false

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "value"
      type = "S"
    }
  ]
  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}