#!/bin/bash

if [[ -z $1 ]]; then
	echo "Usage: $0 [project name] [output filename?]"
	exit 1
fi

pushd . > /dev/null
if ! cd src/$1; then
	echo -e "\033[31mNo project found at ./src/$1\033[m"
	exit 1
fi

if ! dotnet lambda package; then
	exit 1
fi

popd > /dev/null
if ! cp src/$1/bin/Release/**/*.zip .; then
	echo "\033[31mNo src/$1/bin/Release/**/*.zip found.\033[m"
fi

if ! [[ -z $2 ]]; then
	mv *.zip $2
fi
