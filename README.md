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

Create a sample AWS Node Serverless project

```bash
npm run aws-node ${PROJ_NAME}
```

Create project workspace

```bash
mkdir -p ${PROJ_ROOT}
```

Move serverless to project

```bash
mv ${PROJ_NAME} ${PROJ_ROOT}
```

Copy other files

```bash
cp .gitignore package*.json ${PROJ_ROOT}/${PROJ_NAME}
```

Install packages

```bash
cd ${PROJ_ROOT}/${PROJ_NAME}
npm install
```

Put project under source control

```bash
git init
git add .
git commit -m "Initial commit"
```

Run hello locally

```bash
npm run hello
```
