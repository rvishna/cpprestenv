FROM debian:latest

RUN apt-get update && apt-get -y --no-install-recommends install \
    git \
    clang \
    clang-format \
    ca-certificates \
    cmake \
    make \
    lldb \
    libssl-dev \
    libboost-all-dev \
    libz-dev \
    libtinfo5 \
    libcurl4-openssl-dev

RUN git clone --branch v2.10.14 --recurse-submodules https://github.com/microsoft/cpprestsdk.git /usr/local/src/cpprestsdk
RUN cmake -S /usr/local/src/cpprestsdk -B /usr/local/build/cpprestsdk \
    -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DBUILD_SAMPLES=OFF -DBUILD_SHARED_LIBS=OFF && \
    cmake --build /usr/local/build/cpprestsdk --target install && \
    rm -rf /usr/local/build/cpprestsdk /usr/local/src/cpprestsdk

RUN git clone --branch v2.4.1 https://github.com/HowardHinnant/date.git /usr/local/src/date
RUN cmake -S /usr/local/src/date -B /usr/local/build/date -DCMAKE_BUILD_TYPE=Release -DENABLE_DATE_TESTING=OFF && \
    cmake --build /usr/local/build/date --target install && \
    rm -rf /usr/local/build/date /usr/local/src/date

RUN git clone --branch v3.7.0 https://github.com/nlohmann/json.git /usr/local/src/nlohmann-json
RUN cmake -S /usr/local/src/nlohmann-json -B /usr/local/build/nlohmann-json -DCMAKE_BUILD_TYPE=Release -DJSON_BuildTests=OFF && \
    cmake --build /usr/local/build/nlohmann-json --target install && \
    rm -rf /usr/local/build/nlohmann-json /usr/local/src/nlohmann-json

RUN git clone --branch v2.10.0 https://github.com/catchorg/Catch2.git /usr/local/src/catch2
RUN cmake -S /usr/local/src/catch2 -B /usr/local/build/catch2 -DCMAKE_BUILD_TYPE=Release -DCATCH_BUILD_TESTING=OFF && \
    cmake --build /usr/local/build/catch2 --target install && \
    rm -rf /usr/local/build/catch2 /usr/local/src/catch2

RUN git clone --branch v1.4.2 https://github.com/gabime/spdlog.git /usr/local/src/spdlog
RUN cmake -S /usr/local/src/spdlog -B /usr/local/build/spdlog -DCMAKE_BUILD_TYPE=Release -DSPDLOG_BUILD_TESTS=OFF && \
    cmake --build /usr/local/build/spdlog --target install && \
    rm -rf /usr/local/build/spdlog /usr/local/src/spdlog
