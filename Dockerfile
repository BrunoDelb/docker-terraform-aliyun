FROM node:8-alpine

RUN apk add --update --no-cache \
    bash \
    python \
    py-pip \
    groff \
    jq \
    zip \
    curl \
    sed \
    git \
    ca-certificates && \
    pip install --upgrade awscli
# Install serverless
RUN npm install -g serverless
# Install aliyun-cli
RUN wget https://aliyuncli.alicdn.com/aliyun-cli-linux-3.0.2-amd64.tgz
RUN tar -xvzf aliyun-cli-linux-3.0.2-amd64.tgz
RUN rm aliyun-cli-linux-3.0.2-amd64.tgz
RUN mv aliyun /usr/local/bin/
RUN mkdir /root/.aliyun

# aliyun-ossutil
ADD https://gosspublic.alicdn.com/ossutil/1.7.7/ossutil64 /usr/bin/ossutil
RUN chmod a+x /usr/bin/ossutil

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Terraform
ENV TERRAFORM_VERSION=1.0.11

WORKDIR /app
RUN apk update --no-cache
RUN wget -O terraform.zip "http://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
RUN unzip terraform.zip
RUN mv terraform /bin
RUN rm -rf terraform.zip
RUN rm -rf /var/cache/apk/*
RUN apk add graphviz

# Clean
RUN apk -v --purge del py-pip
