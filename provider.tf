terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "project-terraform-state-975050293305"
    key          = "networking/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  alias   = "management"
  region  = "us-east-2"
  profile = "terraform"
}

provider "aws" {
  alias   = "networking"
  region  = "us-east-2"
  profile = "terraform"

  assume_role {
    role_arn = "arn:aws:iam::382755780111:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias   = "workload"
  region  = "us-east-2"
  profile = "terraform"

  assume_role {
    role_arn = "arn:aws:iam::223532248543:role/OrganizationAccountAccessRole"
  }
}