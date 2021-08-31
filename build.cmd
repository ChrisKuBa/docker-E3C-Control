docker build ^
  --no-cache=true ^
  --build-arg BUILD_DATE="%date:~6,4%-%date:~3,2%-%date:~0,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%+01:00" ^
  -t e3dc-control ^
  .