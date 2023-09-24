package main

import (
	_ "image/png"
	"scaling/nearest"
	"scaling/util"

	"log"
)

func init() {
	log.SetFlags(log.Ldate | log.Ltime | log.Lshortfile)
}

func main() {
	img, _ := util.ReadImage("./a.png")
	newImage, err := nearest.Nearest(img, 200, 200)
	if err != nil {
		return
	}
	err = util.SaveImage(newImage, "aaa.png")
	if err != nil {
		return
	}
}
