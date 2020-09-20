# ffmpeg.trailer.bash

### Motivation : Create simple short movie trailer using ffmpeg with ease.

    1. git clone https://github.com/koolwithk/ffmpeg.trailer.bash.git
    2. move images and vidoes to `/opt/input`
    3. bash trailer.sh
    4. Movietrailer.mp4 will be created inside `ffmpeg.trailer.bash/input/output`

## Docker:

    docker run -v /opt/input/:/opt/ffmpeg.trailer.bash/input koolwithk/ffmpeg.trailer.bash
    
## Docker-compose:
#1. Move images or vidoes to `/opt/input` on host machine OR update mount_path in `docker-compose.yml`

    docker-compose up
    
`Movietrailer.mp4` will be created inside `/opt/input/output`

#2. remove  ffmpeg.trailer.bash docker container

    docker-compose down
