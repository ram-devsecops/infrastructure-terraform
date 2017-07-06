![Awwww yeahhhh infrastructure](https://cdn.rawgit.com/silverback-insights/hosted-assets/b9db33da/images/logo-infrastructure.png)

# infrastructure-terraform
Our terraformed infrastructure configuration.

Looking for terraform modules? Visit to our [infrastructure-terraform-modules](https://github.com/silverback-insights/infrastructure-terraform-modules) repo.

## Assumptions
1. You are using MacOS
1. You have already created an AWS account

## Setup

### CLI tool installs
1. [Install **aws cli** ![aws cli](https://www.google.com/s2/favicons?domain=aws.amazon.com)](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
    * `pip install --upgrade --user awscli`
1. Download [terraform ![terraform](https://www.google.com/s2/favicons?domain=www.terraform.io)](https://www.terraform.io/downloads.html) and run installer.
1. Add the terraform to your `PATH`
    * `export PATH=$PATH:<path to terraform binary>`
1. Install [terragrunt ![terragrunt](https://avatars0.githubusercontent.com/u/17118990?v=3&s=16)](https://github.com/gruntwork-io/terragrunt)
    * `brew install terragrunt`

### Terragrunt State Management
1. Create the `terragrunt` iam user for your environment (to manage global state)
    * See [The `terragrunt` user](./user-provisioning/terragrunt) howto

### Run Once Per Environment
Each environment you would like to terraform you will need to perform the following steps exactly once.

1. Create the `terraform-admin` iam user for your environment (to build out the actual infrastructure)
    * Skip this step if already created
    * See [The `terraform-admin` user](./user-provisioning/terraform-admin) howto

### Local Environment Variables
1. Create a file to store your terraform environment variables
    ```
    touch ~/.terraform-env && \
    chmod a+x ~/.terraform-env && \
    nano ~/.terraform-env \
    ;
    ```
1. Copy/paste the following into `~/.terraform-env`:
    ```
    #!/bin/bash

    # Replace with the proper terraform-admin values per environment
    # PG_DB_PASS values should be generated and provided by you
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
    * NOTE: You should run this command everytime you make changes

## Build out the environment
Assuming you ran through all the steps above, you can now build things.

1. `cd ./[env of your choosing]`
1. Run terragrunt commands
    * `terragrunt plan # apply, etc.`
1. Profit.
