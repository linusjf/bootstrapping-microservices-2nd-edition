# Chapter-7

Code and examples for Chapter 7 of [Bootstrapping Microservices](https://www.bootstrapping-microservices.com).

In chapter 7 we build a production environment for microservices on Kubernetes using Terraform.

Please see README in each sub-directory for instructions on starting the particular example.

Before that, run the following command and create a .env file for each example in its specific directory

```bash
az ad sp create-for-rbac --name "terraform-sp" --role="Owner" --scopes="/subscriptions/<your-subscription-id>"
```

Example output

```json
{
  "appId": "11111111-2222-3333-4444-555555555555",
  "displayName": "terraform-sp",
  "password": "abcd1234-ef56-7890-gh12-ijklmnopqrst",
  "tenant": "66666666-7777-8888-9999-000000000000"
}
```

Export them as environment variables in a .env file

```bash
export ARM_CLIENT_ID="11111111-2222-3333-4444-555555555555"
export ARM_CLIENT_SECRET="abcd1234-ef56-7890-gh12-ijklmnopqrst"
export ARM_TENANT_ID="66666666-7777-8888-9999-000000000000"
export ARM_SUBSCRIPTION_ID="your-subscription-id"
```

[Click here to support my work](https://www.codecapers.com.au/about#support-my-work)
