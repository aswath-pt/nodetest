#!/usr/bin/env sh
npm start &
sleep 1
echo $! > .pidfile
echo 'Now...'
echo 'Visit http://192.168.65.129:3000 to see your Node.js/React application in action.'
echo 'created your initial Pipeline as a Jenkinsfile.)'
