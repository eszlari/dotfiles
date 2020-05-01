#!/bin/bash

set -xe

flatpak run org.freedesktop.appstream-glib validate "$1"
flatpak run org.freedesktop.appstream-glib validate-strict "$1"
