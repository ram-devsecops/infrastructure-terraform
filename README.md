![Awwww yeahhhh infrastructure](https://cdn.rawgit.com/silverback-insights/hosted-assets/b9db33da/images/logo-infrastructure.png)

# infrastructure-terraform
Our terraformed infrastructure configuration.

Looking for terraform modules? Visit to our [infrastructure-terraform-modules](https://github.com/silverback-insights/infrastructure-terraform-modules) repo.

## Assumptions
1. You are using MacOS or *nix OS
1. You have already created an AWS account
1. You have already installed the `aws` cli

## Setup
1. Download [terraform ![terraform](https://www.google.com/s2/favicons?domain=www.terraform.io)](https://www.terraform.io/downloads.html) and run installer.
1. Add the terraform binary to your `PATH`
1. Install [terragrunt ![terragrunt](https://avatars0.githubusercontent.com/u/17118990?v=3&s=16)](https://github.com/gruntwork-io/terragrunt)
    (hint: `brew install terragrunt`)
1. Create the `terragrunt` aws user
    * Skip this step if already created
    * See [The `terragrunt` user](./terragrunt) for the howto
1. Create your environment variable file
    * `touch ~/.terraform-env`
    * `chmod a+x ~/.terraform-env`
    * `nano ~/.terraform-env`
    * Copy/paste the following:
    ```
    # Replace with the proper environment info
    export \
      TF_VAR_DEV_AWS_ACCESS_KEY_ID="" \
      TF_VAR_DEV_AWS_SECRET_ACCESS_KEY="" \
      TF_VAR_DEV_AWS_DEFAULT_REGION="" \
      TF_VAR_DEV_PG_DB_PASS="" \
      \
      TF_VAR_STG_AWS_ACCESS_KEY_ID="" \
      TF_VAR_STG_AWS_SECRET_ACCESS_KEY="" \
      TF_VAR_STG_AWS_DEFAULT_REGION="" \
      TF_VAR_STG_PG_DB_PASS="" \
      \
      TF_VAR_PRD_AWS_ACCESS_KEY_ID="" \
      TF_VAR_PRD_AWS_SECRET_ACCESS_KEY="" \
      TF_VAR_PRD_AWS_DEFAULT_REGION="" \
      TF_VAR_PRD_PG_DB_PASS="" \
      ;
    ```
1. Initialize those env vars
    * `source ./load-env.sh`
1. `terragrunt plan # apply, etc.`
1. Profit.
