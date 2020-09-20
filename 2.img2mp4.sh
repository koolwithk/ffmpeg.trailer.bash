function image2mp4() {
  cd $input_path

  list_of_images=$(ls -ltr | awk '{print $NF}' | grep 'vertical2h')
  random_time=$(awk "BEGIN {print 0.8+0.$RANDOM; exit}")

  for image in $list_of_images
  do
  echo "ffmpeg -y -loop 1 -i $image -c:v libx264 -t $random_time -pix_fmt yuv420p -vf scale=$scale,setdar=16:9,setsar=1:1 img2mp4.$image.mp4"
  ffmpeg -y -loop 1 -i $image -c:v libx264 -t $random_time -pix_fmt yuv420p -vf scale=$scale,setdar=16:9,setsar=1:1 img2mp4.$image.mp4
  done
  rm -rf vertical2h.*

}

image2mp4