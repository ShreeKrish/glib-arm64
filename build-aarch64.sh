#! /bin/sh
#
# Copyright (C) 2020 Free Software Foundation, Inc.
# Written by Shree Krish <srm.shreekrish@gmail.com>, 2020.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


function display_help {
    echo -e " Build options :
    -h | --help           -> display build options
    -c | --clean          -> remove the previous built binaries
    -b | --build          -> build glib-2.x for aarch64
    -r | --rebuild        -> full clean build"

    exit
}

function clean {
        # remove the last built build folder
        echo "Cleaning build environment ..."
        rm -rf cross-build
}

function build {
        echo "Build glib for aarch64 ..."
        # cross compile for host defined in cross.glib file
        meson cross-build --cross-file cross.glib
        ninja -C cross-build
}

function rebuild {
        echo "Start clean build ..."
        clean && build
}

# -h | --help           -> display build options
# -c | --clean          -> remove the previous built binaries
# -b | --build          -> build glib-2.x for aarch64
# -r | --rebuild        -> full clean build

options=$(getopt -l "help:help,clean,build,rebuild" -o "h:hcbr" -a -- "$@")

eval set -- "$options"

while true
do
        case $1 in
                -h|--help) display_help
                           exit 0 ;;
                -c|--clean) echo "Clean ..."
                           clean ;;
                -b|--build) echo "Build ..."
                           build ;;
                -r|--rebuild) echo "Rebuild ..."
                           rebuild ;;
                --) break;;
        esac
        exit
done

display_help
