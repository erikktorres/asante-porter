
var com = require("serialport");

if (!module.parent) {
  console.log('Howdy', "let's talk to an insulin pump!");
  var port = '/dev/ttyUSB.AsantePorter0';
  var serial = new com.SerialPort(port, {baudrate: 9600});
  // should beacon at first
  serial.open(function (err) {
    console.log('opened', arguments);
    serial.on('data', function (data) {
      console.log('beacon?', data.length, data);
    });
  });

}
