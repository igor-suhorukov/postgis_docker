FROM postgis/postgis
RUN apt-get update
RUN apt-get install -y pgxnclient make cmake git postgresql-server-dev-all
RUN pgxn install h3

RUN apt-get install -y g++
RUN apt install -y -V ca-certificates lsb-release wget
RUN wget https://apache.bintray.com/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-archive-keyring-latest-$(lsb_release --codename --short).deb
RUN apt install -y -V ./apache-arrow-archive-keyring-latest-$(lsb_release --codename --short).deb
RUN apt update
RUN apt install -y -V libarrow-dev # For C++
RUN apt install -y -V libparquet-dev # For Apache Parquet C++


RUN mkdir parquet_fdw && cd parquet_fdw && git clone https://github.com/adjust/parquet_fdw.git . && make install
