FROM ubuntu as base
WORKDIR /opt
RUN apt update -y \
    && apt install ffmpeg -y \
    && apt install git -y \
    && apt install jq -y

FROM base
RUN cd /opt \
    && git clone https://github.com/koolwithk/ffmpeg.trailer.bash.git
WORKDIR /opt/ffmpeg.trailer.bash
ENTRYPOINT ["/bin/bash", "trailer.sh"]
