#!/bin/bash

BASE_DIR="noto-emoji/build"
IMAGE_DIR="${BASE_DIR}/briar"

if [ ! -d "$IMAGE_DIR" ]; then
	./noto-emoji/materialize_emoji_images.py -s ${BASE_DIR}/compressed_pngs/ -d ${IMAGE_DIR}
	for file in ${IMAGE_DIR}/*
	do
		echo "Resizing ${file}..."
		convert ${file} -resize 64x60 -gravity center -background transparent -extent 64x64 ${file}
	done
else
	echo "Directory ${IMAGE_DIR} does already exist."
fi

echo "Generating sprites..."
./spritegen --emoji-width=64 --emoji-height=64 --emoji-pad-x=0 --emoji-pad-y=0 --emoji="${IMAGE_DIR}"
