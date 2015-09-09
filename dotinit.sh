#!/bin/sh

mv dot.dockerignore .dockerignore
mv dot.gitignore .gitignore

cp dot.env .env.sample
mv dot.env .env

cp coreos/dot.env coreos/.env.sample
mv coreos/dot.env coreos/.env
