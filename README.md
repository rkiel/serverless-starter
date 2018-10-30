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
