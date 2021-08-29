docker buildx build ^
  --platform linux/amd64,linux/arm64,linux/arm/v7 ^
  --no-cache=true ^
  --build-arg BUILD_DATE="%date:~6,4%-%date:~3,2%-%date:~0,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%+01:00" ^
  --build-arg BUILD_VERSION=0.0.1 ^
  -t chriskuba/e3dc-control:latest ^
  --push ^
  .