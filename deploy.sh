zip -r function.zip ./*
aws lambda update-function-code --function-name garbage-reminder --zip-file fileb://function.zip
rm function.zip
