#! bash

git clone https://github.com/raysan5/raylib.git --depth=1

export MACOSX_DEPLOYMENT_TARGET=14.0

cd raylib/src
make

cd ../..
mkdir lib
cp raylib/src/libraylib.a lib
