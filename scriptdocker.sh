#!/bin/bash
# Programa para crear permisos para docker
# Autor: Gabriel
# revisar si ponerlo como sudo o usuario normal con ciertos permisos

sudo adduser userdocker
sudo usermod -aG sudo userdocker
sudo usermod -aG docker userdocker
sudo systemctl status docker
sudo systemctl enable docker
sudo systemctl start docker