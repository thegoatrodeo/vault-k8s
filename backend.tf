# Backend:
terraform {
  required_version = "= 0.14.9"
  #backend "s3" {
  #  bucket  = ""
  #  key     = ""
  #  region  = ""
  #  encrypt = ""
  #  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.3"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = local.config_path
    config_context = local.config_context
  }
}

provider "kubernetes" {
  config_path    = local.config_path
  config_context = local.config_context

}

provider "kubectl" {
  load_config_file = true
  config_path      = local.config_path
  config_context   = local.config_context
}

provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}
