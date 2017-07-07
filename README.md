![Awwww yeahhhh infrastructure](https://cdn.rawgit.com/silverback-insights/hosted-assets/b9db33da/images/logo-infrastructure.png)

# infrastructure-terraform
Our terraformed infrastructure configuration.

Looking for terraform modules? Visit to our [infrastructure-terraform-modules](https://github.com/silverback-insights/infrastructure-terraform-modules) repo.

## Table of Contents
* [Assumptions](#assumptions)
* [Setup](#setup)
    * [CLI tools](#cli-tools)
    * [Terragrunt State Management](#terragrunt-state-management)
    * [Terraform Admin](#terraform-admin)
    * [Local Environment Variables](#local-environment-variables)
* [Build Out](#build-out)
* [TODO](#todo)

## Assumptions
1. You are using MacOS
1. You have already created an AWS account

## Setup

### CLI tools
1. [Install **aws cli** ![aws cli](https://www.google.com/s2/favicons?domain=aws.amazon.com)](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
    * `pip install --upgrade --user awscli`
1. Download [terraform ![terraform](https://www.google.com/s2/favicons?domain=www.terraform.io)](https://www.terraform.io/downloads.html) and run installer.
1. Add the terraform to your `PATH`
    * `export PATH=$PATH:<path to terraform binary>`
1. Install [terragrunt ![terragrunt](https://avatars0.githubusercontent.com/u/17118990?v=3&s=16)](https://github.com/gruntwork-io/terragrunt)
    * `brew install terragrunt`

### Terragrunt State Management
**This should only be performed once for your entire organization (ie not per environment).**

* Create the `terragrunt` iam user for your environment (to manage global state)
* See [The `terragrunt` user](./user-provisioning/terragrunt) howto

*NOTE: It is possible to run multiple times. Every subsequent run will require you to refresh your `terragrunt` aws profile on your local machine.*

### Terraform Admin
This piece creates a `terraform-admin` user that is responsible for building out your entire environment's infrastructure. This user will have `FullAWSAccess` permissions as a result.

**This should be ran once for *each* environment you would like to terraform.**

* Create the `terraform-admin` iam user for your environment (to build out the actual infrastructure)
* Skip this step if you've already completed for the given environment
* See [The `terraform-admin` user](./user-provisioning/terraform-admin) howto

*NOTE: It is possible to run multiple times. Every subsequent run will require you to update the values in your `~/.terraform-env` file and refresh your local environment variables.*

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
    # PG_DB_PASS values should be randomly generated and stored safely by you
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

*NOTE: You should reinitialize your env vars in your terminal session every time you make changes to your `~/.terraform-env` file.*

## Build Out
Assuming you ran through all the steps above, you can now build things.

1. `cd ./[env of your choosing]`
1. Run terragrunt commands
    ```
    # Clear local cached modules
    rm -rf ./.terraform

    # Verify plan looks good
    terragrunt plan

    # Apply changes
    #terragrunt apply # commented out to prevent potentially harmful copy/paste
    ```
1. Profit.

## TODO
* Restrict `terraform-admin` user's permissions to only the minimum set
