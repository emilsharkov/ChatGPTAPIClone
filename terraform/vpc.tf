data "aws_vpc" "existing" {
  id = "vpc-0a03c3012b4c9834a"
}

data "aws_subnet" "existing" {
  count = 2
  id    = ["subnet-093f36c14201aabdc", "subnet-0792fb2da52b6f23f",
          "subnet-0bfbbbeaeb5de8b84","subnet-003eb996dd8ef5013"]
}

data "aws_security_group" "existing" {
  id = "sg-08181a29414b78393"
}
