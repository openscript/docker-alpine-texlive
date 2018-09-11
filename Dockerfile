FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.27

RUN mkdir /tmp/install-tl-unx

WORKDIR /tmp/install-tl-unx

COPY texlive.profile .

# Install TeX Live 2016 with some basic collections
RUN apk --no-cache add perl wget xz tar && \
	wget ftp://tug.org/historic/systems/texlive/2018/install-tl-unx.tar.gz && \
	tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
	./install-tl --profile=texlive.profile && \
	tlmgr install collection-latex collection-latexextra collection-langspanish && \
	apk del perl wget xz tar && \
	cd && rm -rf /tmp/install-tl-unx

# Install additional packages
RUN apk --no-cache add perl=5.24.0-r0 wget=1.18-r2 && \
	tlmgr install bytefield algorithms algorithm2e ec fontawesome && \
	apk del perl wget && \
	mkdir /workdir

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linux:${PATH}"

WORKDIR /workdir

VOLUME ["/workdir"]
