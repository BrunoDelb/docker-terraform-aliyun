# terraform-aliyun

## aliyun-cli

This repository provides the source files to create a Docker image to run Aliyun CLI commands. It embeds too the Serverless Framework and Node.js.

### Build

To build the image:

```
docker build -t devopstestlab/aliyun-cli .
```

### Usage

To use this Docker image, you should follow two steps:
- create the credentials file:

```
docker run -v $PWD/data:/root/.aliyun cli aliyun configure set --profile akProfile --mode AK --region eu-central-1 --access-key-id <ACCESS_KEY_ID> --access-key-secret <ACCESS_KEY_SECRET>
```

`<ACCESS_KEY_ID>` and `<ACCESS_KEY_SECRET>` are the credentials provided by Alibaba Cloud when you create an user with a programmatic access.

A credentials file is created in the `./data/config.json` file.

- execute aliyun-cli command by providing the credentials file:

```
docker run -v $PWD/data:/root/.aliyun:ro cli aliyun ecs DescribeRegions
```

It's a choice to store the credentials, with advantages and disadvantages. This way to do is very practical when you don't want to use interactive commands, for example for CI/CD.

## Terraform

docker run -i -t --rm -v $PWD/app:/app -v credentials:/root/.aws/credentials:ro devopstestlab/terraform-aliyun
