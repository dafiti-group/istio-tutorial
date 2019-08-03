#!/bin/sh
docker run -v `pwd`:/antora --rm -t antora/antora:2.0.0 --pull --stacktrace site-gh-pages.yml
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    gio open gh-pages/istio-tutorial/1.2.x/index.html
elif [[ "$OSTYPE" == "darwin"* ]]; then 
    open gh-pages/istio-tutorial/1.2.x/index.html
fi
