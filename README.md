### Serverless Framework Starter

#### Installation

Clone the repository

```bash
mkdir -p ~/GitHub/rkiel && cd $_
git clone https://github.com/rkiel/serverless-starter.git
```

#### Create a Serverless Framework Project

To create a sample Serverless Framework project, you need to answer two simple questions:

* What is the name of the project?
* Which directory to put the project?

Let's call our project `sample-serverless` and we'll put the project in the `~/projects` directory. Now we can use the `./bin/create` tool to generate the new project.

```bash
cd ~/GitHub/rkiel/serverless-starter

./bin/create -p ~/projects -n sample-serverless
```

This first thing the tool does, is install NPM packages locally, in the current directory. The only package installed should be the `serverless` framework itself.

```bash
npm install
```

The tool then does some directory management. It creates the project directory `~/projects`, if it does not already exist, and it removes the project `sample-serverless` from the current directory, if for some reason it already exists.

```bash
mkdir -p ~/projects
rm -rf ./sample-serverless
```

With the `serverless` framework installed, the tool uses the `serverless create` command to create a new project.

```bash
npm run serverless -- create --template aws-nodejs --path sample-serverless
```

The `serverless create` command creates the project locally, in the current directory.

```text
Serverless: Generating boilerplate...
Serverless: Generating boilerplate in "~/GitHub/rkiel/serverless-starter/sample-serverless"
 _______                             __
|   _   .-----.----.--.--.-----.----|  .-----.-----.-----.
|   |___|  -__|   _|  |  |  -__|   _|  |  -__|__ --|__ --|
|____   |_____|__|  \___/|_____|__| |__|_____|_____|_____|
|   |   |             The Serverless Application Framework
|       |                           serverless.com, v1.32.0
 -------'

Serverless: Successfully generated boilerplate for template: "aws-nodejs"
```

I'm not aware of a way for the command to create the project in some directory other than the current. But that's okay, the tool will just move it to our project directory.

```bash
mv ./sample-serverless ~/projects
```

For the remainder of our Serverless Framework project creation, the tool will operate inside the new project directory.

```bash
cd ~/projects/sample-serverless
```

The `serverless create` command only generates two files: `serverless.yml` and `handler.js`. Not enought to make it a standalone project. So the tool does a few things to bootstrap our project. First, initialize our project as a Node.js project by creating a `package.json` file.

```bash
npm init -y
```

Second, the tool will install the `serverless`.framework locally.

```bash
npm install --save serverless
```

And finally, the tool initializes our project as `git` repository.

```bash
git init
git add .
git commit -m 'Initial commit'
```

We now have a sample Serverless Framework project.

#### Run a Sample Function

As mentioned previously, the `serverless create` command generates a `handler.js` which is a simple Hello World function. We can verify that our sample project is working by invoking that function.

```bash
cd ~/projects/sample-serverless

npm run serverless -- invoke local --function hello
```

You should see something like the following.

```json
{
  "statusCode": 200,
  "body": "{\"message\":\"Go Serverless v1.0! Your function executed successfully!\",\"input\":\"\"}"
}
```

### Core Concepts ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/intro/))

1.  A **Function** is an AWS Lambda function. It's an independent unit of deployment, like a microservice.
1.  Anything that triggers an AWS Lambda Function to execute is regarded by the Framework as an **Event**.
1.  **Resources** are AWS infrastructure components which your Functions use
1.  A **Service** is the Framework's unit of organization. You can think of it as a project file, though you can have multiple services for a single application. It's where you define your Functions, the Events that trigger them, and the Resources your Functions use, all in one file
1.  You can overwrite or extend the functionality of the Framework using **Plugins**.

### Services ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/services/))

* A service is like a project. It's where you define your AWS Lambda Functions, the events that trigger them and any AWS infrastructure resources they require, all in a file called serverless.yml.
* In the beginning of an application, many people use a single Service to define all of the Functions, Events and Resources for that project.
* However, as your application grows, you can break it out into multiple services. A lot of people organize their services by workflows or data models, and group the functions related to those workflows and data models together in the service.
* Note: Currently, every service will create a separate REST API on AWS API Gateway. Due to a limitation with AWS API Gateway, you can only have a custom domain per one REST API. If you plan on making a large REST API, please make note of this limitation.
* `serverless create --template aws-nodejs --path myService`

### Variables ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/variables/))

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

### Resources ([Notes from serverless.com](https://serverless.com/framework/docs/providers/aws/guide/resources/))

* Every stage you deploy to with serverless.yml using the aws provider is a single AWS CloudFormation stack.
* Define your AWS resources in a property titled `resources`. What goes in this property is raw CloudFormation template syntax
* You can overwrite/attach any kind of resource to your CloudFormation stack.
