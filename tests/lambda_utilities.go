package test

import (
	"archive/zip"
	"fmt"
	"io"
	"os"
	"testing"
)

func packageLambda(t *testing.T, variant string) {
	terraformDir := fmt.Sprintf("../examples/%s", variant)

	handlerLocation := fmt.Sprintf("%s/src/main.py", terraformDir)
	zipLocation := fmt.Sprintf("%s/artifacts/deploy.zip", terraformDir)

	file, err := os.Create(zipLocation)
	if err != nil {
		t.Fatal(err)
	}
	defer file.Close()

	wr := zip.NewWriter(file)
	defer wr.Close()

	handlerFile, err := os.Open(handlerLocation)
	if err != nil {
		t.Fatal(err)
	}
	defer handlerFile.Close()

	wHandler, err := wr.Create("main.py")
	if err != nil {
		t.Fatal(err)
	}
	io.Copy(wHandler, handlerFile)
}
