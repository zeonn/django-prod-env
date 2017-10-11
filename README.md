django-prod-env
========================

Production environment for running Django applications with docker containers


Consist of:
------------

two different parts:
1. "all-in-one": single environment for django (gunicorn) + nginx in on docker compose configuration
2. "back-front": separeted configuration for running one or many different backends with one frontend
