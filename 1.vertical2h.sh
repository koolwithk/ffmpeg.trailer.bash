function vertical2h() {
  cd $input_path
  rm -rf vertical2h.*

  list_of_images=$(ls -ltr | awk '{print $NF}' | egrep 'png|PNG|jpeg|JPEG|jpg|JPG' | grep -v vertical2h)

  for image in $list_of_images
  do
  echo "ffmpeg -y -i $image -vf scale="$scale:force_original_aspect_ratio=decrease,pad=$scale:\(ow-iw\)/2:\(oh-ih\)/2" vertical2h.$image.jpg"
  ffmpeg -y -i $image -vf scale="$scale:force_original_aspect_ratio=decrease,pad=$scale:\(ow-iw\)/2:\(oh-ih\)/2" vertical2h.$image.jpg
  done
}

vertical2h