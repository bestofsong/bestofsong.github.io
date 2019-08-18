#!/usr/bin/env bash
repo_url="http://code.smartstudy.com/wansong/ti-mobile"
checkout='feature/react-native-init'

function help {
  echo "Usage: $0 <project_directory_name> [optional git refspec you want to be at rep: ${repo_url}]"
  if [ $# -lt 1 ] ; then
    exit -1
  elif [ $1 = "-h" ] || [ $1 = "--help" ] ; then
    exit 0
  else
    exit -1
  fi
}

if [ $# -lt 1 ] || [ $1 = "-h" ] || [ $1 = "--help" ] ; then
  help "$@"
fi


proj_dir=$1
if [ $# -gt 1 ] ; then
  checkout="$2"
fi


set -e


if [ -d "${proj_dir}" ] ; then
  echo "Directory already exists: ${proj_dir}!"
  exit -1
fi

tmp_repo=`mktemp -d`
git clone "${repo_url}" "$tmp_repo"
pushd "${tmp_repo}"
git checkout "${checkout}"
popd

rm -rf "${tmp_repo}/.git"
mv "${tmp_repo}" "${proj_dir}"
