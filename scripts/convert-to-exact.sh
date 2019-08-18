#! /bin/sh
SCRIPT=`which $0`
if [ "x$(echo $SCRIPT | grep -e '^/')" = "x" ] ; then
  path=`pwd`/$SCRIPT
else
  path=$SCRIPT
fi

path_package_json=$(dirname "${path}")/../package.json

function get_deps {
  local dep=$1
local mods=$(node <<NODE
const p = require('$path_package_json');
const excludes = new Set(['react', 'react-native']);
Object.keys(p.$dep).forEach(k => !excludes.has(k) && console.log(k));
NODE
)
  echo $mods
}

function fix_mods {
  local is_dev=$1
  shift
  local names=$*
  local name_ver_pairs=''

  for name in $names ; do
    local path_mod=$(dirname "${path}")/../node_modules/"${name}"
    local path_pkg=${path_mod}/package.json
    local vers=$(node <<NODE
    const p = require('$path_pkg');
    console.log(p.version);
NODE
)
    name_ver_pairs="${name_ver_pairs} ${name}@${vers}"
  done

  if [ $is_dev -gt 0 ] ; then
    yarn add --dev --exact $name_ver_pairs
  else
    yarn add --exact $name_ver_pairs
  fi
}


deps=`get_deps dependencies`
fix_mods 0 "${deps}" 

dev_deps=`get_deps devDependencies`
fix_mods 1 "${dev_deps}"

