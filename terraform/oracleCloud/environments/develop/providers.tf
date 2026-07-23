provider "kubernetes" {

  host = module.oke.cluster_endpoint

  cluster_ca_certificate = base64decode(
    module.oke.cluster_ca
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "oci"

    args = [
      "ce",
      "cluster",
      "generate-token",
      "--cluster-id",
      module.oke.cluster_id
    ]
  }
}

provider "flux" {
  #kubernetes = {
  #  config_path = "~/.kube/config"
  #}

  kubernetes = {
    host = module.oke.cluster_endpoint
  }

  git = {
    url = var.github_repo

    http = {
      username = var.github_username
      password = var.github_token
    }
  }
}

provider "github" {
  owner = var.github_owner
  token = var.github_token
}

provider "oci" {
  config_file_profile = "DEFAULT"
  config_file         = pathexpand("~/.oci/config")
}