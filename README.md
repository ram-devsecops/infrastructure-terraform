![Awwww yeahhhh infrastructure](https://cdn.rawgit.com/silverback-insights/hosted-assets/b9db33da/images/logo-infrastructure.png)

# infrastructure-terraform
Our terraformed infrastructure configuration.

Looking for terraform modules? Visit to our [infrastructure-terraform-modules](https://github.com/silverback-insights/infrastructure-terraform-modules) repo.

## Setup
1. Download [terraform ![terraform](https://www.google.com/s2/favicons?domain=www.terraform.io)](https://www.terraform.io/downloads.html) and run installer.
2. Add the terraform binary to your PATH
2. Install [terragrunt ![terragrunt](https://avatars0.githubusercontent.com/u/17118990?v=3&s=16)](https://github.com/gruntwork-io/terragrunt)
    (hint: `brew install terragrunt`)
3. Export env vars (or add them to your `~/.bash_profile`)...
  ```
  export \
    AWS_ACCESS_KEY_ID="<terragrunt key>" \
    AWS_SECRET_ACCESS_KEY="<terragrunt secret>" \
    AWS_DEFAULT_REGION="us-east-2" \
    \
    TF_VAR_DEV_AWS_ACCESS_KEY_ID="<dev admin key>" \
    TF_VAR_DEV_AWS_SECRET_ACCESS_KEY="<dev admin secret>" \
    TF_VAR_DEV_AWS_DEFAULT_REGION="us-east-2" \
    TF_VAR_DEV_PG_DB_PASS="<pg db pass>" \
    \
    TF_VAR_STG_AWS_ACCESS_KEY_ID="<stg admin key>" \
    TF_VAR_STG_AWS_SECRET_ACCESS_KEY="<stg admin secret>" \
    TF_VAR_STG_AWS_DEFAULT_REGION="us-east-2" \
    TF_VAR_STG_PG_DB_PASS="<stg pg db pass>" \
    \
    TF_VAR_PRD_AWS_ACCESS_KEY_ID="<prd admin key>" \
    TF_VAR_PRD_AWS_SECRET_ACCESS_KEY="<prd admin secret>" \
    TF_VAR_PRD_AWS_DEFAULT_REGION="us-east-2" \
    TF_VAR_PRD_PG_DB_PASS="<prd pg db pass>" \
    ;

  # ...and for good measure bc ya know, naming is hard
  export \
    AWS_ACCESS_KEY="$AWS_ACCESS_KEY_ID" \
    AWS_SECRET_KEY="$AWS_SECRET_ACCESS_KEY" \
    AWS_REGION="$AWS_DEFAULT_REGION" \
    ;

  ```
4. `terragrunt plan # init, apply, etc.`
5. Profit.
