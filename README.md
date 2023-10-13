# A simple and Free AWS infrastructure for hosting your **TeslaMate**

[TelsaMate](https://github.com/adriankumpf/teslamate) is a famous application used by Tesla fans to monitor the data of their car(s).

## Important Notice

We developped this infrastructure, using the maximum of [free services of AWS](https://aws.amazon.com/free/), in order to provide an easy way to test the [TelsaMate](https://github.com/adriankumpf/teslamate) application for free.

This infra is meant to be free of use during 12 months. Passed this period, **you'll be charged by AWS based on the infrastruture real cost**.

We could not be responsible of any extra charge or costs if you wanted to pursue its usage, or if you forgot to disable it, after this period of time.

## Remarks

As we use the [free services of AWS](https://aws.amazon.com/free/), this infra is as simple as possible. No Certificate, no Domain, no LoadBalancing, no Instance High Availability, etc...

We use the [basic Docker installation mode](https://docs.teslamate.org/docs/installation/docker), as the [Advanced installation modes](https://docs.teslamate.org/docs/guides/traefik) are too heavy for the `t2.micro` free instance type.

## About Security

The access to the [TelsaMate](https://github.com/adriankumpf/teslamate) application will be secured using IP filtering. Your IP@ and only your IP@ (provided by your internet provider) will be allowed to connect to the application. [We added a way to declare multiple IPs, if you want to access it from several places](#i-own-several-homes-how-to-allow-the-access-from-multiple-places)

> No other way than [refreshing the IP filtering](#my-ip-did-change-how-to-update-the-ip-filtering) if it changes daily. For a more convenient use, you may require a fix IP@ to your Internet provider.

## Requirements

* You must own an AWS account.
* You must have installed the [Auth for Tesla](https://apps.apple.com/us/app/auth-app-for-tesla/id1552058613) aplication on your phone.

## Steps by Steps Instructions

### Create the AWS Account

* Create your personal [Amazon Web Service Account](https://aws.amazon.com/free/), following the AWS wizard.

* Create another basic IAM user (e.g `Admin`), with the **Administrator** rights, that will be used for provisioning the infrastruture.

* Create a pair of `AWS Access Key ID` and `AWS Secret Access Key` for this user. You need them for the next step below.

### Configure Your Machine

* Install the [AWS Command Line Interface](https://aws.amazon.com/fr/cli/).

* To configure your [AWS Command Line Interface](https://aws.amazon.com/fr/cli/), type :

    ```shell
    aws configure
    ```

* At prompt, enter your credentials information as follow :

    ```text
    AWS Access Key ID :     <Paste your AWS Access Key ID>
    AWS Secret Access Key : <Paste your AWS Secret Access Key>
    Default region name :
    Default output format :
    ```

### Build the Infrastructure

* Download and install [Terraform](https://developer.hashicorp.com/terraform/downloads) in version **1.6.1**. 

> If you download another version, change the `/code/version.tf` file and the `required_version = "1.6.1"` attribute accordingly to you version.

* Clone our repository :

    ```shell
    # via SSH
    git clone git@github.com:devteam418/myteslamate.git

    # via HTTP
    git clone https://github.com/devteam418/myteslamate.git
    # Then enter your github credentials
    ```

* Browse into the `code` folder of our repository :

    ```shell
    cd myteslamate/code
    ````

* Build the Infrastructure 

    ```shell
    terraform init
    terraform apply --auto-approve
    ```

## Connect to TeslaMate

* On the AWS Console, in the `EC2` service, search for the **MyTeslaMate** instance.
* Copy its **Public IPv4 DNS** link. (e.g `ec2-172-217-18-206.eu-west-3.compute.amazonaws.com`)
* Paste the link in your browser as follow : `http://`**ec2-172-217-18-206.eu-west-3.compute.amazonaws.com**`:3000`

> At first logon, you may have to use the [Auth for Tesla](https://apps.apple.com/us/app/auth-app-for-tesla/id1552058613) application, and enter both the **Access Token** and **Refresh Token**.

---

## How To ?

### I own several homes. How to allow the access from multiple places ?

* Edit the `code/TOCHANGE.tf` file.
* Add any other IPs using the **allowed-ip-map** variable.
* Relaunch the build of the Infrastructure 

    ```shell
    terraform apply --auto-approve
    ```

### My IP@ did change. How to update the IP filtering ?

* Relaunch the build of the Infrastructure 

    ```shell
    terraform apply --auto-approve
    ```

---

## Common Errors

