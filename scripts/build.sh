#! /bin/bash
for dd in documents experiments scripts static works ; do
  npx static-site-builder -d $dd
done
