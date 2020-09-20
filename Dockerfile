FROM ubuntu as base
WORKDIR /opt
RUN apt update -y \
    && apt install ffmpeg -y \
    && apt install git -y 

RUN git clone https://github.com/koolwithk/ffmpeg.trailer.bash.git

FROM base
WORKDIR /opt/trailer.bash
CMD "bash trailer.sh"