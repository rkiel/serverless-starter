### Serverless Framework Starter

#### Installation

Clone the repository

```bash
mkdir -p ~/GitHub/rkiel && cd $_
git clone https://github.com/rkiel/serverless-starter.git
```

Install packages

```bash
cd ~/GitHub/rkiel/serverless-starter
npm install
```

#### Create a Sample Serverless Project

Define the name of your project

```bash
PROJ_ROOT=~/projects
PROJ_NAME=sample-serverless
```

Create a project workspace

```bash
mkdir -p ${PROJ_ROOT}
```

Create a sample AWS Node serverless project

```bash
npm run serverless -- create --template aws-nodejs --path ${PROJ_NAME}
```

Move serverless project to project workspace

```bash
mv ${PROJ_NAME} ${PROJ_ROOT}
```

Copy other files to serverless project

```bash
cp .gitignore package*.json ${PROJ_ROOT}/${PROJ_NAME}
```

#### Working with Sample Serverless Project

Go to new serverless project

```bash
cd ${PROJ_ROOT}/${PROJ_NAME}
```

Install packages

```bash
npm install
```

Run hello locally

```bash
npm run serverless -- invoke local --function hello
```

Put project under source control

```bash
git init
git add .
git commit -m "Initial commit"
```

#### Core Concepts ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/intro/))

1.  A **Function** is an AWS Lambda function. It's an independent unit of deployment, like a microservice.
1.  Anything that triggers an AWS Lambda Function to execute is regarded by the Framework as an **Event**.
1.  **Resources** are AWS infrastructure components which your Functions use
1.  A **Service** is the Framework's unit of organization. You can think of it as a project file, though you can have multiple services for a single application. It's where you define your Functions, the Events that trigger them, and the Resources your Functions use, all in one file
1.  You can overwrite or extend the functionality of the Framework using **Plugins**.

#### Services ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/services/))

* A service is like a project. It's where you define your AWS Lambda Functions, the events that trigger them and any AWS infrastructure resources they require, all in a file called serverless.yml.
* In the beginning of an application, many people use a single Service to define all of the Functions, Events and Resources for that project.
* However, as your application grows, you can break it out into multiple services. A lot of people organize their services by workflows or data models, and group the functions related to those workflows and data models together in the service.
* Note: Currently, every service will create a separate REST API on AWS API Gateway. Due to a limitation with AWS API Gateway, you can only have a custom domain per one REST API. If you plan on making a large REST API, please make note of this limitation.
* `serverless create --template aws-nodejs --path myService`

#### Variables ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/variables/))

* Variables allow users to dynamically replace config values in serverless.yml config.
* To use variables, you will need to reference values enclosed in ${} brackets.
* You can only use variables in serverless.yml property values, not property keys.
* You can also Recursively reference properties with the variable system.
* Format
  * ${variableSource}
  * ${variableSource, defaultValue}
* Referencing Environment Variables
  * ${env:SOME_VAR}
  * "${env:}" will embed the complete process.env object
* Referencing CLI Options
  * ${opt:some_option}
  * "${opt:}" will embed the complete options object
* Reference Properties In serverless.yml
  * ${self:levelOne.levelTwo.someProperty}
* Reference Variables in External YAML/JSON files
  * ${file(../myFile.yml):someProperty}
  * It is important that the file you are referencing has the correct suffix (.yml for YAML or .json for JSON)
* Referencing S3 Objects
  * ${s3:myBucket/myKey}
* Reference Variables in Javascript Files
  * `${file(../myFile.js):someModule}`
* Multiple Configuration Files
  * Adding many custom resources to your serverless.yml file could bloat the whole file, so you can use the Serverless Variable syntax to split this up.
  * `Resources: $${file(cloudformation-resources.json)}`
  * `- ${file(resources/first-cf-resources.yml)}`

#### Resources ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/resources/))

* Every stage you deploy to with serverless.yml using the aws provider is a single AWS CloudFormation stack.
* Define your AWS resources in a property titled `resources`. What goes in this property is raw CloudFormation template syntax
* You can overwrite/attach any kind of resource to your CloudFormation stack.
