FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.27

RUN mkdir /tmp/install-tl-unx

WORKDIR /tmp/install-tl-unx

COPY texlive.profile .

# Install TeX Live 2016 with some basic collections
RUN apk --no-cache add perl wget xz tar && \
	wget ftp://tug.org/historic/systems/texlive/2018/install-tl-unx.tar.gz && \
	tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
	./install-tl --profile=texlive.profile && \
	apk del perl wget xz tar && \
	cd && rm -rf /tmp/install-tl-unx

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linux:${PATH}"

# Install additional packages
RUN apk --no-cache add perl wget python && \
	tlmgr install latexmk && \
	mkdir /workdir

WORKDIR /workdir

VOLUME ["/workdir"]
