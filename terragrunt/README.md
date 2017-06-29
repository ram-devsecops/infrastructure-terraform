# The `terragrunt` user ![terragrunt](https://avatars0.githubusercontent.com/u/17118990?v=3&s=32)
This terraform configuration is only intended to be ran once to setup the `terragrunt` user with the proper permissions.

## Why?
Remotely managed state is a good thing for agile teams. If you want Terragrunt to remotely manage state it is wise to create an isolated user. One with a limited permissions to right resources.

Luckily, we've built this module for you ✅.

## How?

To create the `terragrunt` user:
```
  # Replace with your own AWS creds
  export \
    TF_VAR_AWS_ACCESS_KEY_ID="" \
    TF_VAR_AWS_SECRET_ACCESS_KEY="" \
    TF_VAR_AWS_DEFAULT_REGION="" \

  # PWD: ./terragrunt
  terraform plan && \
  echo "No errors found in your evil plan. Applying now..." && \
  terraform apply \
  ;

```

Now go get your grunt on.
