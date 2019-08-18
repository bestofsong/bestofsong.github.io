#! /bin/sh

prefix='更新时间：'
now_date=`TZ=Asia/Shanghai date "+${prefix}%Y-%m-%d %H:%M:%S GMT+8"`


function do_file() {
  sed -i.bak -E "s/<body>(${prefix}[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}[[:space:]][[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}[[:space:]]GMT\+8<br[[:space:]]\/>)?/<body>${now_date}<br \/>/" "$1" && rm "$1.bak"
}

git status --short | awk '{ print $2; }' | while read file ; do f=`echo "$file" | grep -E '\.html$' | grep -v -E '(^|\/)index\.html$'` ; [ -n "$f" ] && [ -f "$f" ] && do_file "$f"  ; done

