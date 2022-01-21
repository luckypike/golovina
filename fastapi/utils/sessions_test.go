package utils

import (
	"fmt"
	"testing"
)

func TestDecrypt(t *testing.T) {
	cookie := "zOP58S9uag/obRt0XJcj6nWVkTeTAiQC0EFOVvBkID+0Tkk2vT3SpQJGlp3C0eRDWDnVKKMcKj1U6jGc5p6Ecx4TaHceTtxc16rAmZFmArviYQ4IMA8ZRfJB1h4zVc95g2LCKm7wblkcXfwRVrmKFEmjP+2Klg2lVhuYOHPdVAjI9CgSVPEJl1GhudKWMKrgRkNA69RZlzwgBurnB1/+sU3ICScrE7N+WiP8Ya7QFIjHQhsZvwfV0MdpeQV8AI+S5ya/tgkiP21p+mCVgggNwfRaKvGX9/t9sKNcbVvwXrn8lzrAT1Eq1ZveUXj8s2G0FTT7YHQ=--GU4hdRSCMETIoeLt--a8v+58Njk/cv3+cubhxeSg=="
	userId := Decrypt(cookie)

	if userId != 1 {
		t.Errorf("Expected 1, received %v", userId)
	}
}

func TestWrongDecrypt(t *testing.T) {
	cookie := "11111"
	userId := Decrypt(cookie)

	fmt.Println(userId)

	if userId != 0 {
		t.Errorf("Expected 0, received %v", userId)
	}
}
