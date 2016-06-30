#!/bin/bash

if [ "$1" == "-o" ]; then
    if ! [ -f "$2" ]; then
        echo -n  > "$2"
    fi
    ext="${2##*.}"
    if [ $ext == "cpp" ]; then
        echo -n '#include <iostream>
#include <vector>
#include <numeric>
#include <string>
#include <algorithm>
#include <map>
#include <cmath>
#include <set>
#include <queue>
#include <stack>
#include <cstring>
#include <ctime>
#include <cstdlib>
#include <cassert>

using namespace std;

#define mem(a, v) memset(a, v, sizeof (a))
#define x first
#define y second
#define all(a) (a).begin(), (a).end()
#define mp make_pair
#define pb push_back
#define sz(x) int((x).size())
#define rep(i, n) for (int i = 0; i < int(n); i ++)
#define repi(i, a, n) for (int i = (a); i < int(n); i ++)
#define repe(x, v) for (auto x: (v))

int main () {
    std::ios_base::sync_with_stdio(false);
    return 0;
}' > $2
    fi
    vim "$2"
    exit 0
fi

if ! [ -f $1 ]; then
    echo "$1 file not found"
    exit 0
fi

dir=$(dirname $1)
filename="${1##*/}"
extension="${filename##*.}"
filebasename="${filename%.*}"

if [ $extension == "cpp" ]; then
    g++ "$dir/$filename" -o "$dir/$filebasename.o" -std=c++11 -Wall && "$dir/$filebasename.o"
    rm -f "$dir/$filebasename.o"
elif [ $extension == "py" ]; then
    python "$dir/$filename"
else
    echo "No support for .$extension files"
fi

