terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "CLOUDFLARE_ACCOUNT_ID" {
  type = string
}

resource "cloudflare_pages_project" "vite-react" {
  account_id        = var.CLOUDFLARE_ACCOUNT_ID
  name              = "vite-react"
  production_branch = "main"

  build_config {
    build_command   = "npx @cloudflare/next-on-pages@1"
    destination_dir = ".vercel/output/static"
  }

  source {
    type = "github"
    config {
      owner                         = "snaveevans"
      repo_name                     = "vite-react"
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_branch_excludes       = ["main"]
    }
  }

  deployment_configs {
    preview {
      environment_variables = {
        ENVIRONMENT  = "preview-2"
        NODE_VERSION = "18"
      }
      compatibility_date  = "2023-03-14"
      compatibility_flags = ["nodejs_compat"]
    }
    production {
      environment_variables = {
        NODE_VERSION = "18"
      }
      compatibility_date  = "2023-03-14"
      compatibility_flags = ["nodejs_compat"]
    }
  }

}

