package utils

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/sha1"
	"encoding/base64"
	"encoding/json"
	"os"
	"strings"

	"golang.org/x/crypto/pbkdf2"
)

func Decrypt(cookie string) float64 {
	defer func() {
		if r := recover(); r != nil {
			return
		}
	}()

	secret := pbkdf2.Key([]byte(os.Getenv("RAILS_SECRET_KEY")), []byte(os.Getenv("RAILS_SALT")), 1000, 32, sha1.New)

	block, _ := aes.NewCipher(secret)
	aesgcm, _ := cipher.NewGCM(block)

	encryptedData := strings.Split(cookie, "--")

	data, _ := base64.StdEncoding.DecodeString(encryptedData[0])
	iv, _ := base64.StdEncoding.DecodeString(encryptedData[1])
	authTag, _ := base64.StdEncoding.DecodeString(encryptedData[2])

	data = []byte(append(data, authTag...))
	plaintext, _ := aesgcm.Open(nil, iv, data, nil)

	var mp map[string]interface{}

	json.Unmarshal(plaintext, &mp)
	b, _ := base64.StdEncoding.DecodeString(mp["_rails"].(map[string]interface{})["message"].(string))
	json.Unmarshal(b, &mp)

	return mp["warden.user.user.key"].([]interface{})[0].([]interface{})[0].(float64)
}
