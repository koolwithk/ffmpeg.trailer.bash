function audio() {
  cd $input_path

  #audio gain on concatenate -15db
  echo "ffmpeg -y -i concatenate.mp4 -vcodec copy -af "volume=-15dB" audiogain.mp4"
  ffmpeg -y -i concatenate.mp4 -vcodec copy -af "volume=-15dB" audiogain.mp4
  rm -rf concatenate.mp4

  #add background song
  song=$(ls -ltr | awk '{print $NF}' | grep '.mp3' | sed -n 1p)
  if [[ "$song" == "" ]]
  then
    echo "ffmpeg -y -i "../sample/dummysong.mp3" -i audiogain.mp4 -filter_complex '[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]' -map 1:v -map "[out]" -c:v copy -shortest added_audio.mp4"
    ffmpeg -y -i "../sample/dummysong.mp3" -i audiogain.mp4 -filter_complex '[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]' -map 1:v -map '[out]' -c:v copy -shortest added_audio.mp4
  else
    echo "ffmpeg -y -i "$song" -i audiogain.mp4 -filter_complex '[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]' -map 1:v -map "[out]" -c:v copy -shortest added_audio.mp4"
    ffmpeg -y -i "$song" -i audiogain.mp4 -filter_complex '[0:a][1:a]amerge,pan=stereo|c0<c0+c2|c1<c1+c3[out]' -map 1:v -map "[out]" -c:v copy -shortest added_audio.mp4
  fi
  rm -rf audiogain.mp4

  #audio fade_in and fade_out
  #get added_audio.mp4 length
  video_length=$(ffprobe -v quiet -print_format json -show_streams added_audio.mp4 | jq '.streams[0].duration' | sed 's/"//g' | cut -d . -f1)
  echo "$video_length"
  if (( "$video_length" > 6 ))
  then
  #temp_video_length for audio fadeout
  temp_video_length=$(($video_length-3))
  echo "ffmpeg -i added_audio.mp4 -af "afade=t=in:ss=0:d=2,afade=t=out:st="$temp_video_length":d=2" fade.mp4"
  ffmpeg -i added_audio.mp4 -af "afade=t=in:ss=0:d=3,afade=t=out:st="$temp_video_length":d=3" fade.mp4
  else
  mv added_audio.mp4 fade.mp4
  fi
  rm -rf added_audio.mp4
}

audio