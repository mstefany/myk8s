locals {
  aws_vars = read_terragrunt_config(find_in_parent_folders("aws.hcl"))

  aws_region = local.aws_vars.locals.aws_region
  aws_profile = local.aws_vars.locals.aws_profile

  aws_state_bucket = local.aws_vars.locals.aws_state_bucket
  aws_lock_table = local.aws_vars.locals.aws_lock_table
}


remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = local.aws_state_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = local.aws_lock_table
    profile        = local.aws_profile

    skip_bucket_accesslogging   = true
    skip_metadata_api_check     = true
    skip_credentials_validation = true
  }
}

generate "providers" {
  path      = "_providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
EOF
}
