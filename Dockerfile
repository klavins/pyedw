FROM jupyter/scipy-notebook

USER root

COPY setup/krb5.conf /etc/krb5.conf

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y gnupg2 && \
    apt-get install -y software-properties-common

RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list

RUN apt-get update  

RUN env ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev
    
WORKDIR /home/jovyan/work