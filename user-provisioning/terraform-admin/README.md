# The `terraform-admin` user <img src="https://www.google.com/s2/favicons?domain=www.terraform.io" height="30"/>
This terraform configuration is only intended to be ran once to setup the `terraform-admin` user with the proper permissions to build out infrastructure.

## Why?
Because building everything out with your root AWS creds is just bad practice.

## How?

To create the `terraform-admin` user...
  * `cd ./terraform-admin`
  * Add your root AWS creds to the current terminal session
    ````
    # Values provided by your root AWS creds
    export \
      TF_VAR_AWS_ACCESS_KEY_ID="" \
      TF_VAR_AWS_SECRET_ACCESS_KEY="" \
      TF_VAR_AWS_DEFAULT_REGION="" \
      ;
    ````
  * Test out your config and `apply` if there are no errors
    ````
    terraform plan && \
      echo "No errors found in your evil plan. Applying now..." && \
      terraform apply \
      ;

    ````

You should see an output *similar* to the following if everything was peachy

![success](https://cdn.rawgit.com/silverback-insights/hosted-assets/6d1123b8/images/terragrunt-user-output.png)

**IMPORTANT: Copy/paste the `key, secret, and region` into your `~/.terrform-env` file appropriately.**

Now go get your terraform on.
