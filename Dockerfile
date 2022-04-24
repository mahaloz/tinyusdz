FROM ubuntu:18.04

USER root 
RUN apt-get update && apt-get install -y bsdutils python3-dev python-pip \
    automake autoconf coreutils bison libacl1-dev llvm clang \
    build-essential git libffi-dev cmake libreadline-dev libtool vim \
    meson ninja-build


# ----- target ----- #
# get source and compile
RUN git clone https://github.com/mahaloz/tinyusdz.git && \
    cd /tinyusdz/tests/fuzzer && \
    CXX=clang++ CC=clang meson build -Db_sanitize=address && \
    cd build && \
    ninja && \
    cp fuzz_usdaparser /fuzzme
