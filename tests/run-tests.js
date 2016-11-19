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
  const mautic = spawn( 'npm', ["run", "start-mautic"], { stdio: "ignore" } )
  setTimeout( function() {
    const behat = spawn( 'bin/behat', argv, { stdio: "inherit" } )
    behat.on( 'exit', ( code ) => {
      program.kill()
      exec( 'pgrep -f "router.php" | xargs kill' );
      process.exit( code );
    } )
  }, 10000 )
} )
