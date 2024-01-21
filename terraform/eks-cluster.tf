provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "existing" {
  id = "vpc-0a03c3012b4c9834a"
}

data "aws_subnet" "existing" {
  for_each = toset(["subnet-093f36c14201aabdc", "subnet-0792fb2da52b6f23f", "subnet-0bfbbbeaeb5de8b84", "subnet-003eb996dd8ef5013"])
  id       = each.value
}

data "aws_iam_role" "eks_cluster_role" {
  name = "eksClusterRole"
}

data "aws_iam_role" "eks_node_group_role" {
  name = "AmazonEKSNodeRole"
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn = data.aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [for s in data.aws_subnet.existing : s.id]
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = data.aws_iam_role.eks_node_group_role.arn
  subnet_ids      = [for s in data.aws_subnet.existing : s.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
