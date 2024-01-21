provider "kubernetes" {
  host                   = aws_eks_cluster.my_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.my_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.my_cluster.token
}

data "aws_eks_cluster_auth" "my_cluster" {
  name = aws_eks_cluster.my_cluster.name
}

resource "kubernetes_manifest" "my_deployment" {
  manifest = file("${path.module}/../k8s/deployment.yaml")
}

resource "kubernetes_manifest" "my_service" {
  manifest = file("${path.module}/../k8s/service.yaml")
}
