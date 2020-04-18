#!/usr/bin/env bash
set -e

if hash md5deep 2>/dev/null; then
    echo "Has MD5Deep"
else
    echo "Please install md5deep using brew install hashdeep OR sudo apt-get install md5deep"
    exit 5
fi

if hash golint 2>/dev/null; then
    echo "Has golint"
else
    go get -u golang.org/x/lint/golint
fi


md5deep -r . | sort -k2 >/tmp/before
echo "Insure all code is formatted"
go fmt ./...

echo "Insure all code is linted"
golint --set_exit_status=true ./...

echo "Insure all code is vetted"
go vet ./...

echo "Insure all code passes unit tests and coverage is updated appropriately"
go clean -testcache
go test ./... -coverprofile=coverage.txt -covermode=atomic
md5deep -r . | sort -k2 >/tmp/after

if [[ $# -ne 1 ]] && [[ $1 != "true" ]]; then
    # If any changes from format or unit test coverage then fail so people check in the formatted files and updated coverage
    echo "If any changes from format or unit test coverage then fail so people check in the formatted files and updated coverage"
    diff /tmp/before /tmp/after
fi