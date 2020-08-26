#set -e

# ensure the docker app is running
open -g -a Docker.app || exit
# Wait for the server to start up, if applicable.
i=0
while ! docker system info &>/dev/null; do
  (( i++ == 0 )) && printf %s '-- Waiting for Docker to finish starting up...' || printf '.'
  sleep 1
done
(( i )) && printf '\n'

# be sure to update paths within the adjacent .toml if you choose to run this
# python ./whitenoise-core/scripts/update_version.py

echo "(A) clean, delete all temporary directories";
bash scripts/clean.sh

echo "(B) set up manylinux docker";
DOCKER_IMAGE=quay.io/pypa/manylinux2010_x86_64
docker pull $DOCKER_IMAGE
chmod +x scripts/build_manylinux_binaries.sh


echo "(C) build manylinux binary";
docker run --rm -v `pwd`:/io $DOCKER_IMAGE /io/scripts/build_manylinux_binaries.sh

echo "(D) store binary in temp directory";
mkdir tmp_binaries
rm -f tmp_binaries/libwhitenoise_ffi.so
cp whitenoise-core/target/release/libwhitenoise_ffi.so tmp_binaries/libwhitenoise_ffi.so

# # check check for GLIBC_ <= ~2.3. Typically memcpy is an example that links to GLIBC ~2.15
# docker run --rm -v `pwd`:/io $DOCKER_IMAGE objdump -T /io/opendp/whitenoise/core/lib/libwhitenoise_ffi.so | grep GLIBC_
# # check that all necessary libraries are statically linked (look for non-existence of gmp/mpfr/mpc/openssl)
# docker run --rm -v `pwd`:/io $DOCKER_IMAGE ldd /io/opendp/whitenoise/core/lib/libwhitenoise_ffi.so

echo "(E) mac binaries/packaging";
python3 scripts/code_generation.py

# # check that all necessary libraries are statically linked (look for non-existence of gmp/mpfr/mpc/openssl)
# otool -L opendp/whitenoise/core/lib/libwhitenoise_ffi.dylib


echo "(F) move prior manylinux binary into the library";
cp tmp_binaries/libwhitenoise_ffi.so opendp/whitenoise/core/lib

echo "(G) package into wheel";
#workon psi
python3 setup.py bdist_wheel -d ./wheelhouse