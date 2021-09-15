FROM rabbitmq:3.9.5-management

RUN apt-get update -y && \
    apt-get install -y erlang-eldap

RUN rabbitmq-plugins enable rabbitmq_auth_backend_ldap && \
    rabbitmq-plugins enable rabbitmq_trust_store
