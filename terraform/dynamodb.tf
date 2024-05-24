resource "aws_dynamodb_table" "todo" {
  name         = "todo"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "_id"

  attribute {
    name = "_id"
    type = "S" # S for string type. Adjust if your partition key type is different
  }

  tags = {
    Name = "todo"
  }
}