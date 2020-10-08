FROM jupyter/scipy-notebook

USER root

COPY setup/krb5.conf /etc/krb5.conf

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y gnupg2 && \

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list

RUN apt-get install -y mssql-tools && \
    apt-get install -y unixodbc-dev