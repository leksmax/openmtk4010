#!/bin/bash
docker run -it -d --name dpi_01 \
	-h dpi_01 \
	--network host --privileged \
	capc.withusp.com:443/ndpi:dev01 \
	/bin/bash

