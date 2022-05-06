# ffmpeg.trailer.bash

### Motivation : Create simple short movie trailer using ffmpeg with ease.

## Docker:

```bash
docker run -v /opt/input/:/opt/ffmpeg.trailer.bash/input koolwithk/ffmpeg.trailer.bash
```
    
## Docker-compose:
#1. Move images or vidoes to `/opt/input` on host machine OR update mount_path in `docker-compose.yml`

```bash
docker-compose up
```

    1. apt install ffmpeg
    2. git clone https://github.com/koolwithk/ffmpeg.trailer.bash.git
    3. move images and vidoes to ffmpeg.trailer.bash/input/
    4. bash trailer.sh
    5. Movietrailer.mp4 will be created inside ffmpeg.trailer.bash/input/output


`Movietrailer.mp4` will be created inside `/opt/input/output`

#2. remove  ffmpeg.trailer.bash docker container

    docker-compose down

## Working:

    1. Convert all images(jpg,jpeg,png) to 1 second MP4 video
    2. Randomly select 2-3 seconds of clip from all mp4 video
    3. Add slowmotion to all video
    4. Add .mp3 as background song if present in "input" directory
    5. Add some movie effect on video
    6. Movietrailer.mp4 will be created inside input/output directory