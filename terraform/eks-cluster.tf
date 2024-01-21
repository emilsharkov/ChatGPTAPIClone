resource "aws_eks_cluster" "my_cluster" {
  name     = "api-cluster"
  role_arn = "arn:aws:iam::449754346595:role/eksClusterRole"

  vpc_config {
    subnet_ids = [for s in data.aws_subnet.existing : s.id]
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "api-node-group"
  node_role_arn   = "arn:aws:iam::449754346595:role/AmazonEKSNodeRole"
  subnet_ids      = [for s in data.aws_subnet.existing : s.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
