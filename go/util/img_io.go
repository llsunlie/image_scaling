package util

import (
	"bufio"
	"image"
	"image/jpeg"
	"log"
	"os"
)

func SaveImage(img image.Image, filename string) error {
	outFile, err := os.Create(filename)
	if err != nil {
		return err
	}
	defer outFile.Close()
	b := bufio.NewWriter(outFile)
	err = jpeg.Encode(b, img, nil)
	if err != nil {
		return err
	}
	err = b.Flush()
	if err != nil {
		return err
	}
	return nil
}

func ReadImage(filename string) (image.Image, error) {
	f, err := os.Open(filename)
	if err != nil {
		log.Print("err", err)
		return nil, err
	}
	defer f.Close()
	img, _, err := image.Decode(f)
	if err != nil {
		log.Print("err", err)
		return nil, err
	}
	return img, nil
}
