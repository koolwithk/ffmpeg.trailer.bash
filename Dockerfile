FROM ubuntu as base
WORKDIR /opt
RUN apt update -y \
    && apt install ffmpeg -y \
    && apt install git -y \
    && apt install jq -y

RUN git clone https://github.com/koolwithk/ffmpeg.trailer.bash.git

FROM base
WORKDIR /opt/ffmpeg.trailer.bash
ENTRYPOINT ["/bin/bash", "trailer.sh"]
