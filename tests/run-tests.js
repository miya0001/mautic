const phantomjs = require( 'phantomjs-prebuilt' )
const spawn = require( 'child_process' ).spawn
const exec = require( 'child_process' ).exec

const argv = process.argv
argv.shift()
argv.shift()

phantomjs.run(
  '--webdriver=4444',
  '--ignore-ssl-errors=yes',
  '--cookies-file=/tmp/webdriver_cookie.txt'
).then( program => {
  const behat = spawn( 'bin/behat', argv, { stdio: "inherit" } )
  behat.on( 'exit', ( code ) => {
    program.kill()
    process.exit( code );
  } )
} )
