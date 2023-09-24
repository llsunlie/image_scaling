package nearest

import (
	"errors"
	"image"
	"image/color"
	"log"
	"math"
)

func Nearest(oldImg image.Image, newImgX int, newImgY int) (image.Image, error) {
	xRatio := float32(oldImg.Bounds().Size().X) / float32(newImgX)
	yRatio := float32(oldImg.Bounds().Size().Y) / float32(newImgY)
	newImage := image.NewRGBA(image.Rect(0, 0, newImgX, newImgY))
	for i := 0; i < newImgX; i++ {
		x := int(math.Floor(float64(float32(i) * xRatio)))
		for j := 0; j < newImgY; j++ {
			y := int(math.Floor(float64(float32(j) * yRatio)))
			r, g, b, a := oldImg.At(x, y).RGBA()
			if (image.Point{X: x, Y: y}.In(oldImg.Bounds())) {
				newImage.SetRGBA(i, j, color.RGBA{R: uint8(r), G: uint8(g), B: uint8(b), A: uint8(a)})
			} else {
				log.Print("边界问题")
				return nil, errors.New("边界问题")
			}
		}
	}
	return newImage, nil
}
